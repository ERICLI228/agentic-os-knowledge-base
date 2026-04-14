# 🎙️ VoiceClone Pro - iOS APP 核心代码

> **SwiftUI + Core ML 实现**

---

## 📱 主入口

```swift
// VoiceClonePro/App/VoiceCloneProApp.swift
import SwiftUI

@main
struct VoiceCloneProApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(VoiceStore())
                .environmentObject(TTSEngine())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        // 配置音频会话
        AudioSessionManager.shared.configure()
        return true
    }
}
```

---

## 🎙️ 录音模块

```swift
// VoiceClonePro/Core/AudioRecorder.swift
import AVFoundation
import Combine

class AudioRecorder: ObservableObject {
    @Published var isRecording = false
    @Published var currentTime: TimeInterval = 0
    @Published var audioLevel: Float = -160 // dB
    
    private var audioRecorder: AVAudioRecorder?
    private var timer: Timer?
    private var startTime: Date?
    
    // 行业最佳实践：48kHz AAC
    private let settings: [String: Any] = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 48000,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
        AVEncoderBitRateKey: 128000 // 128kbps
    ]
    
    func requestPermission() async -> Bool {
        await AVAudioSession.sharedInstance().requestRecordPermission()
    }
    
    func startRecording() async throws {
        guard await requestPermission() else {
            throw AudioError.permissionDenied
        }
        
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
        try session.setActive(true)
        
        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("recording_\(UUID().uuidString).m4a")
        
        audioRecorder = try AVAudioRecorder(url: url, settings: settings)
        audioRecorder?.isMeteringEnabled = true
        audioRecorder?.record()
        
        isRecording = true
        startTime = Date()
        
        // 实时监测音量
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.updateMeters()
        }
    }
    
    func stopRecording() -> Recording? {
        guard let recorder = audioRecorder else { return nil }
        
        timer?.invalidate()
        timer = nil
        
        let duration = Date().timeIntervalSince(startTime ?? Date())
        recorder.stop()
        
        isRecording = false
        
        return Recording(
            id: UUID(),
            url: recorder.url,
            duration: duration,
            createdAt: Date()
        )
    }
    
    private func updateMeters() {
        audioRecorder?.updateMeters()
        audioLevel = audioRecorder?.averagePower(forChannel: 0) ?? -160
    }
}

enum AudioError: Error {
    case permissionDenied
    case recordingFailed
    case invalidFormat
}
```

---

## 🧠 Core ML 特征提取

```swift
// VoiceClonePro/Core/VoiceFeatureExtractor.swift
import CoreML
import Accelerate
import AVFoundation

class VoiceFeatureExtractor {
    
    /// 提取声音特征（本地Core ML）
    func extractFeatures(from audioURL: URL) async throws -> VoiceFeatures {
        // 1. 加载音频
        let audioFile = try AVAudioFile(forReading: audioURL)
        let format = audioFile.processingFormat
        
        // 2. 读取音频数据
        let frameCount = UInt32(audioFile.length)
        guard let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount) else {
            throw FeatureError.bufferCreationFailed
        }
        try audioFile.read(into: buffer)
        
        // 3. 转换为MLMultiArray
        guard let floatChannelData = buffer.floatChannelData else {
            throw FeatureError.invalidAudioData
        }
        
        let audioData = Array(UnsafeBufferPointer(
            start: floatChannelData[0],
            count: Int(frameCount)
        ))
        
        // 4. 预处理（重采样到16kHz，适合语音模型）
        let processedAudio = try preprocessAudio(audioData, fromSampleRate: format.sampleRate)
        
        // 5. 提取MFCC特征
        let mfcc = try extractMFCC(from: processedAudio)
        
        // 6. 提取音高特征
        let pitch = try extractPitch(from: processedAudio)
        
        // 7. 生成声音嵌入（使用转换后的Core ML模型）
        let embedding = try await generateEmbedding(from: processedAudio)
        
        return VoiceFeatures(
            mfcc: mfcc,
            pitch: pitch,
            timbre: extractTimbre(from: mfcc),
            embedding: embedding
        )
    }
    
    /// 预处理音频（重采样、降噪）
    private func preprocessAudio(_ audio: [Float], fromSampleRate: Double) throws -> [Float] {
        let targetSampleRate = 16000.0
        
        // 简单重采样（实际项目使用vDSP）
        let ratio = targetSampleRate / fromSampleRate
        let newLength = Int(Double(audio.count) * ratio)
        
        var resampled = [Float](repeating: 0, count: newLength)
        
        // 使用vDSP进行高质量重采样
        var input = audio
        var output = resampled
        
        vDSP_desamp(
            &input,
            vDSP_Stride(1.0 / ratio),
            &output,
            vDSP_Length(newLength)
        )
        
        // 归一化
        var maxVal: Float = 0
        vDSP_maxv(&output, 1, &maxVal, vDSP_Length(newLength))
        var scale = 1.0 / maxVal
        vDSP_vsmul(&output, 1, &scale, &output, 1, vDSP_Length(newLength))
        
        return output
    }
    
    /// 提取MFCC特征
    private func extractMFCC(from audio: [Float]) throws -> [[Float]] {
        // 使用Accelerate框架的vDSP_DFT
        // 实际项目中使用更高效的实现
        
        let frameSize = 512
        let hopSize = 256
        let numFrames = (audio.count - frameSize) / hopSize + 1
        
        var mfccFeatures: [[Float]] = []
        
        for i in 0..<numFrames {
            let start = i * hopSize
            let end = start + frameSize
            let frame = Array(audio[start..<end])
            
            // 加窗
            var windowed = frame
            applyHammingWindow(&windowed)
            
            // FFT
            let fft = try performFFT(windowed)
            
            // 梅尔滤波器组
            let melSpectrum = applyMelFilterBank(fft)
            
            // DCT得到MFCC
            let mfcc = applyDCT(melSpectrum)
            
            mfccFeatures.append(mfcc)
        }
        
        return mfccFeatures
    }
    
    /// 生成声音嵌入（使用Core ML）
    private func generateEmbedding(from audio: [Float]) async throws -> [Float] {
        // 加载转换后的Core ML模型
        let config = MLModelConfiguration()
        config.computeUnits = .all // 使用ANE + GPU + CPU
        
        // 实际项目中加载转换后的模型
        // let model = try await VoiceEncoder.load(configuration: config)
        
        // 模拟嵌入向量（256维）
        return (0..<256).map { _ in Float.random(in: -1...1) }
    }
    
    private func applyHammingWindow(_ signal: inout [Float]) {
        let length = signal.count
        for i in 0..<length {
            let window = 0.54 - 0.46 * cos(2.0 * .pi * Float(i) / Float(length - 1))
            signal[i] *= window
        }
    }
    
    private func performFFT(_ signal: [Float]) throws -> [Float] {
        let log2n = vDSP_Length(log2(Float(signal.count)))
        guard let fftSetup = vDSP_create_fftsetup(log2n, FFTRadix(kFFTRadix2)) else {
            throw FeatureError.fftSetupFailed
        }
        defer { vDSP_destroy_fftsetup(fftSetup) }
        
        var real = signal
        var imag = [Float](repeating: 0, count: signal.count)
        
        real.withUnsafeMutableBufferPointer { realPtr in
            imag.withUnsafeMutableBufferPointer { imagPtr in
                var splitComplex = DSPSplitComplex(realp: realPtr.baseAddress!, imagp: imagPtr.baseAddress!)
                vDSP_fft_zrip(fftSetup, &splitComplex, 1, log2n, FFTDirection(kFFTDirection_Forward))
            }
        }
        
        // 计算幅度谱
        var magnitudes = [Float](repeating: 0, count: signal.count / 2)
        for i in 0..<signal.count / 2 {
            magnitudes[i] = sqrt(real[i] * real[i] + imag[i] * imag[i])
        }
        
        return magnitudes
    }
    
    private func applyMelFilterBank(_ spectrum: [Float]) -> [Float] {
        // 简化实现，实际使用26-40个梅尔滤波器
        return spectrum
    }
    
    private func applyDCT(_ melSpectrum: [Float]) -> [Float] {
        // 简化实现，实际提取13-40个MFCC系数
        return Array(melSpectrum.prefix(13))
    }
    
    private func extractPitch(from audio: [Float]) throws -> [Float] {
        // 使用YIN算法或自相关法提取音高
        // 简化实现
        return []
    }
    
    private func extractTimbre(from mfcc: [[Float]]) -> [Float] {
        // 计算MFCC的统计特征（均值、方差等）作为音色特征
        guard !mfcc.isEmpty else { return [] }
        
        let numCoefficients = mfcc[0].count
        var timbre = [Float](repeating: 0, count: numCoefficients)
        
        for i in 0..<numCoefficients {
            let values = mfcc.map { $0[i] }
            timbre[i] = values.reduce(0, +) / Float(values.count)
        }
        
        return timbre
    }
}

struct VoiceFeatures {
    let mfcc: [[Float]]
    let pitch: [Float]
    let timbre: [Float]
    let embedding: [Float]
}

enum FeatureError: Error {
    case bufferCreationFailed
    case invalidAudioData
    case fftSetupFailed
    case modelLoadingFailed
}
```

---

## 🌐 API服务

```swift
// VoiceClonePro/Services/APIService.swift
import Foundation

class APIService {
    static let shared = APIService()
    
    private let baseURL = "https://api.voiceclone.pro/api/v1"
    private let session: URLSession
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 300
        self.session = URLSession(configuration: config)
    }
    
    // MARK: - 声音分析
    
    func analyzeVoice(audioURL: URL) async throws -> VoiceAnalysis {
        let url = URL(string: "\(baseURL)/voice/analyze")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let data = try await createMultipartBody(audioURL: audioURL, boundary: boundary)
        request.httpBody = data
        
        let (responseData, _) = try await session.data(for: request)
        return try JSONDecoder().decode(VoiceAnalysis.self, from: responseData)
    }
    
    // MARK: - 声音复刻
    
    func createCloneTask(
        name: String,
        recordings: [Recording],
        description: String?
    ) async throws -> CloneTask {
        let url = URL(string: "\(baseURL)/clone/train")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = [
            "name": name,
            "description": description ?? "",
            "recording_ids": recordings.map { $0.id.uuidString }
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, _) = try await session.data(for: request)
        return try JSONDecoder().decode(CloneTask.self, from: data)
    }
    
    func checkCloneStatus(taskId: String) async throws -> CloneProgress {
        let url = URL(string: "\(baseURL)/clone/status/\(taskId)")!
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode(CloneProgress.self, from: data)
    }
    
    // MARK: - TTS合成
    
    func synthesizeSpeech(
        text: String,
        voiceId: String,
        settings: TTSSettings
    ) async throws -> URL {
        let url = URL(string: "\(baseURL)/tts/synthesize")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "text": text,
            "voice_id": voiceId,
            "speed": settings.speed,
            "pitch": settings.pitch,
            "volume": settings.volume,
            "emotion": settings.emotion.rawValue
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.synthesisFailed
        }
        
        let result = try JSONDecoder().decode(TTSResult.self, from: data)
        
        // 下载音频文件
        let (audioData, _) = try await session.data(from: result.audioURL)
        
        // 保存到本地
        let localURL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("tts_\(UUID().uuidString).mp3")
        
        try audioData.write(to: localURL)
        
        return localURL
    }
    
    // MARK: - Helper
    
    private func createMultipartBody(audioURL: URL, boundary: String) async throws -> Data {
        var data = Data()
        
        let audioData = try Data(contentsOf: audioURL)
        
        data.append("--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"audio\"; filename=\"recording.m4a\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: audio/m4a\r\n\r\n".data(using: .utf8)!)
        data.append(audioData)
        data.append("\r\n".data(using: .utf8)!)
        data.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return data
    }
}

// MARK: - Models

struct VoiceAnalysis: Codable {
    let voiceId: String
    let features: VoiceFeatureData
    let quality: VoiceQuality
}

struct VoiceFeatureData: Codable {
    let pitchRange: Float
    let speakingRate: Float
    let timbre: [Float]
}

struct VoiceQuality: Codable {
    let score: Int
    let clarity: Float
    let noiseLevel: Float
}

struct CloneTask: Codable, Identifiable {
    let id: String
    let name: String
    let status: TaskStatus
    let createdAt: Date
}

struct CloneProgress: Codable {
    let taskId: String
    let status: TaskStatus
    let progress: Double
    let estimatedTimeRemaining: TimeInterval?
    let errorMessage: String?
}

struct TTSResult: Codable {
    let audioURL: URL
    let duration: TimeInterval
}

enum TaskStatus: String, Codable {
    case pending = "pending"
    case processing = "processing"
    case training = "training"
    case completed = "completed"
    case failed = "failed"
}

enum APIError: Error {
    case synthesisFailed
    case networkError
    case decodingError
}
```

---

## 🎨 UI界面

```swift
// VoiceClonePro/Views/RecordView.swift
import SwiftUI

struct RecordView: View {
    @StateObject private var recorder = AudioRecorder()
    @State private var recordings: [Recording] = []
    @State private var showingPermissionAlert = false
    
    var body: some View {
        VStack(spacing: 30) {
            // 录音波形可视化
            AudioVisualizer(audioLevel: recorder.audioLevel)
                .frame(height: 100)
                .padding()
            
            // 录音时长
            Text(formatTime(recorder.currentTime))
                .font(.system(size: 64, weight: .thin, design: .monospaced))
                .foregroundColor(recorder.isRecording ? .red : .primary)
            
            // 录音按钮
            RecordButton(isRecording: recorder.isRecording) {
                toggleRecording()
            }
            .frame(width: 100, height: 100)
            
            // 录音列表
            List(recordings) { recording in
                RecordingRow(recording: recording)
            }
        }
        .navigationTitle("录音")
        .alert("需要麦克风权限", isPresented: $showingPermissionAlert) {
            Button("去设置") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            Button("取消", role: .cancel) {}
        }
    }
    
    private func toggleRecording() {
        if recorder.isRecording {
            if let recording = recorder.stopRecording() {
                recordings.append(recording)
            }
        } else {
            Task {
                do {
                    try await recorder.startRecording()
                } catch AudioError.permissionDenied {
                    showingPermissionAlert = true
                } catch {
                    print("录音失败: \(error)")
                }
            }
        }
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let milliseconds = Int((time.truncatingRemainder(dividingBy: 1)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
}

// 录音按钮组件
struct RecordButton: View {
    let isRecording: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(isRecording ? Color.red : Color.blue)
                    .frame(width: 80, height: 80)
                
                if isRecording {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                } else {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 70, height: 70)
                    
                    Circle()
                        .fill(Color.red)
                        .frame(width: 60, height: 60)
                }
            }
        }
    }
}

// 音频可视化组件
struct AudioVisualizer: View {
    let audioLevel: Float
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 4) {
                ForEach(0..<20) { index in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(colorForBar(index))
                        .frame(width: (geometry.size.width - 76) / 20)
                        .frame(height: heightForBar(index, in: geometry.size.height))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .animation(.easeInOut(duration: 0.1), value: audioLevel)
        }
    }
    
    private func heightForBar(_ index: Int, in maxHeight: CGFloat) -> CGFloat {
        let normalizedLevel = (audioLevel + 60) / 60 // 转换为0-1
        let randomFactor = CGFloat.random(in: 0.3...1.0)
        return maxHeight * CGFloat(normalizedLevel) * randomFactor
    }
    
    private func colorForBar(_ index: Int) -> Color {
        let normalizedLevel = (audioLevel + 60) / 60
        if normalizedLevel > 0.8 {
            return .red
        } else if normalizedLevel > 0.5 {
            return .orange
        } else {
            return .green
        }
    }
}

// 录音行组件
struct RecordingRow: View {
    let recording: Recording
    @State private var isPlaying = false
    
    var body: some View {
        HStack {
            Image(systemName: isPlaying ? "stop.circle.fill" : "play.circle.fill")
                .font(.title2)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading) {
                Text("录音 \(recording.id.uuidString.prefix(8))")
                    .font(.headline)
                Text(formatDuration(recording.duration))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(recording.createdAt, style: .time)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
```

---

## 📊 数据模型

```swift
// VoiceClonePro/Models/VoiceProfile.swift
import Foundation
import SwiftData

@Model
class VoiceProfile {
    @Attribute(.unique) var id: UUID
    var name: String
    var description: String?
    var createdAt: Date
    var updatedAt: Date
    
    // 声音特征
    var pitchRange: Float
    var speakingRate: Float
    var timbreVector: Data? // 存储为二进制数据
    
    // 训练状态
    var trainingStatus: String
    var trainingProgress: Double
    
    // 关联录音
    @Relationship(deleteRule: .cascade) var recordings: [Recording]?
    
    init(
        id: UUID = UUID(),
        name: String,
        description: String? = nil,
        pitchRange: Float = 0,
        speakingRate: Float = 0
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.createdAt = Date()
        self.updatedAt = Date()
        self.pitchRange = pitchRange
        self.speakingRate = speakingRate
        self.trainingStatus = "pending"
        self.trainingProgress = 0
    }
}

@Model
class Recording {
    @Attribute(.unique) var id: UUID
    var url: URL
    var duration: TimeInterval
    var createdAt: Date
    
    @Relationship(inverse: \VoiceProfile.recordings) var voiceProfile: VoiceProfile?
    
    init(id: UUID = UUID(), url: URL, duration: TimeInterval) {
        self.id = id
        self.url = url
        self.duration = duration
        self.createdAt = Date()
    }
}
```

---

## 🚀 使用示例

```swift
// 使用示例
struct ContentView: View {
    @StateObject private var recorder = AudioRecorder()
    @StateObject private var featureExtractor = VoiceFeatureExtractor()
    
    var body: some View {
        VStack {
            Button("开始录音") {
                Task {
                    try? await recorder.startRecording()
                }
            }
            
            Button("提取特征") {
                Task {
                    if let recording = recorder.stopRecording() {
                        do {
                            let features = try await featureExtractor.extractFeatures(from: recording.url)
                            print("MFCC: \(features.mfcc.count) 帧")
                            print("音色特征: \(features.timbre)")
                        } catch {
                            print("特征提取失败: \(error)")
                        }
                    }
                }
            }
        }
    }
}
```

---

*代码实现: 2026-04-14 02:25 PDT*  
*技术栈: SwiftUI + Core ML + FastAPI*