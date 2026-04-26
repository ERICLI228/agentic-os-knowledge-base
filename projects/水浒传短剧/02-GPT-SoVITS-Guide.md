---
title: "02-GPT-SoVITS-Guide"
created: 2026-04-24
updated: 2026-04-24
tags: [项目, 项目/短剧]
status: draft
---
# 🎙️ GPT-SoVITS WebUI 训练与推理详细操作指南

> **系统状态**: ✅ WebUI 运行中 (http://127.0.0.1:9874)  
> **武松模型**: ✅ 已训练完成 (`wusong_v3_gpt.ckpt` + `wusong_v3_sovits.pth`)  
> **原始录音**: ✅ 10 个 WAV 文件 (`原-武松-01.wav` ~ `原-武松-10.wav`)

---

## 🔧 第一部分：环境准备

### 1.1 系统要求
| 组件 | 要求 | 当前状态 |
|------|------|----------|
| Python | 3.9-3.12 | ✅ Python 3.12 |
| PyTorch | 2.5+ | ✅ 已安装 |
| GPU | 推荐 (可 CPU) | ✅ Apple Silicon |
| 内存 | ≥16GB | ✅ 足够 |

### 1.2 服务启动
```bash
# 启动 WebUI (如果未运行)
cd ~/GPT-SoVITS && python webui.py

# 验证服务状态
curl -s http://127.0.0.1:9874/ | head -3
# 应返回 HTML 内容

# 查看进程
ps aux | grep webui.py
```

**WebUI 地址**: http://127.0.0.1:9874

---

## 📂 第二部分：数据准备

### 2.1 原始音频要求
**位置**: `~/GPT-SoVITS/raw_data/`

**文件格式要求**:
- 格式: `.wav` (推荐) 或 `.mp3/.m4a`
- 采样率: ≥16kHz (推荐 32kHz)
- 时长: 单文件 3-10 秒最佳
- 内容: 清晰人声，无背景音乐
- 数量: ≥1 分钟总时长 (武松有 ~12 分钟)

### 2.2 武松数据集详情
```bash
# 原始录音文件 (10 个)
原-武松-01.wav  # 112KB
原-武松-02.wav  # 1.5MB  
...
原-武松-10.wav  # 1.7MB

# 处理后的短音频 (用于训练)
wusong_2_武松.m4a   # 参考音频
mac_002_武松.m4a    # 切片音频
...
```

### 2.3 数据预处理 (WebUI 操作)
1. **访问 WebUI**: http://127.0.0.1:9874
2. **切换到 "1-数据预处理" 标签页**
3. **配置参数**:
   - 人物名称: `wusong`
   - 音频语言: `中文`
   - 目标采样率: `32000`
   - 是否切割音频: `是`
   - 最小切片长度: `3.0` 秒
   - 最大切片长度: `10.0` 秒

4. **上传音频**: 将 `原-武松-*.wav` 文件放入 `raw_data/` 目录
5. **点击 "开始处理"**

**处理流程**:
```
原始音频 → 人声分离 → 自动切片 → ASR 识别 → 文本标注 → 训练数据
```

---

## 🏋️ 第三部分：模型训练

### 3.1 S1 阶段训练 (SoVITS - 声音特征提取)

**WebUI 操作步骤**:
1. **切换到 "2-SoVITS 训练" 标签页**
2. **选择人物**: `wusong`
3. **配置训练参数**:
   - Batch Size: `2` (Apple Silicon 限制)
   - 学习率: `0.0001`
   - Epochs: `10`
   - GPU 设备: `mps` (Apple Silicon)

4. **点击 "开始训练"**

**训练监控**:
- 日志位置: `~/GPT-SoVITS/logs/wusong/train.log`
- 模型保存: `~/GPT-SoVITS/SoVITS_weights/wusong_v3_sovits.pth`
- 训练时长: ~2-4 小时 (Apple Silicon)

### 3.2 S2 阶段训练 (GPT - 语义理解)

**WebUI 操作步骤**:
1. **切换到 "3-GPT 训练" 标签页**
2. **选择人物**: `wusong`
3. **配置参数**:
   - Batch Size: `2`
   - 学习率: `0.0001`
   - Epochs: `10`
   - 预训练模型: `gsv-v2final-pretrained`

4. **点击 "开始训练"**

**训练监控**:
- 日志位置: `~/GPT-SoVITS/logs/wusong/train.log`
- 模型保存: `~/GPT-SoVITS/GPT_weights/wusong_v3_gpt.ckpt`
- 训练时长: ~3-5 小时 (Apple Silicon)

### 3.3 武松训练结果
✅ **S1 完成**: `wusong_v3_sovits.pth` (399MB)  
✅ **S2 完成**: `wusong_v3_gpt.ckpt` (158MB)  
✅ **训练日志**: `~/GPT-SoVITS/logs/wusong/train.log`

---

## 🎯 第四部分：语音推理（生成配音）

### 4.1 WebUI 推理操作

**步骤**:
1. **切换到 "4-推理" 标签页**
2. **加载模型**:
   - SoVITS 模型: `wusong_v3_sovits.pth`
   - GPT 模型: `wusong_v3_gpt.ckpt`
3. **配置参考音频**:
   - 音频文件: `wusong_2_武松.m4a`
   - 参考文本: `"景阳冈上酒气冲天。"`
4. **输入目标文本**: 
   ```
   喂！主人家，快拿酒来！
   ```
5. **调整参数**:
   - 语速: `1.0`
   - 噪声: `0.6`
   - 长度惩罚: `1.0`
6. **点击 "生成"**

### 4.2 批量推理脚本

**脚本位置**: `~/GPT-SoVITS/generate_wusong_13_real.py`

**使用方法**:
```bash
# 生成 13 句武松配音
python ~/GPT-SoVITS/generate_wusong_13_real.py

# 输出位置
~/GPT-SoVITS/output/wusong_real/vo_01.wav ~ vo_13.wav
```

**脚本核心逻辑**:
```python
# 参考音频配置
REF_AUDIO = "/Users/hokeli/GPT-SoVITS/raw_data/wusong_2_武松.m4a"
REF_TEXT = "景阳冈上酒气冲天。"

# 模型路径
GPT_MODEL = "/Users/hokeli/GPT-SoVITS/GPT_weights/wusong_v3_gpt.ckpt"
SOVITS_MODEL = "/Users/hokeli/GPT-SoVITS/SoVITS_weights/wusong_v3_sovits.pth"

# 13 句台词列表
LINES = [
    "喂！主人家，快拿酒来！",
    "好酒！有肉吗？快拿些来吃。",
    # ... 共 13 句
]
```

### 4.3 API 推理调用

**直接调用 WebUI API**:
```bash
# 单句生成示例
curl -X POST http://127.0.0.1:9874/tts \
  -H "Content-Type: application/json" \
  -d '{
    "text": "喂！主人家，快拿酒来！",
    "text_lang": "zh",
    "ref_audio_path": "/Users/hokeli/GPT-SoVITS/raw_data/wusong_2_武松.m4a",
    "prompt_text": "景阳冈上酒气冲天。",
    "prompt_lang": "zh",
    "gpt_model_path": "/Users/hokeli/GPT-SoVITS/GPT_weights/wusong_v3_gpt.ckpt",
    "sovits_model_path": "/Users/hokeli/GPT-SoVITS/SoVITS_weights/wusong_v3_sovits.pth"
  }' \
  --output output.wav
```

---

## ⚡ 第五部分：性能优化与故障排除

### 5.1 Apple Silicon 优化设置

**训练配置优化** (`config.json`):
```json
{
  "train": {
    "batch_size": 2,        // 减少 batch size 避免内存溢出
    "fp16_run": false,      // Apple Silicon 不支持 FP16
    "gpu_numbers": "0"      // 使用 MPS 后端
  },
  "data": {
    "sampling_rate": 32000  // 平衡质量与速度
  }
}
```

### 5.2 常见问题解决

#### ❌ 问题1: 声音不像原始录音
**原因**: 参考音频与目标文本风格不匹配  
**解决方案**:
- 选择与目标台词情感相近的参考音频
- 调整 `noise` 参数 (0.3-0.8)
- 增加训练数据多样性

#### ❌ 问题2: 训练过程中断
**原因**: Apple Silicon 内存限制  
**解决方案**:
- 减少 `batch_size` 到 1
- 关闭其他应用程序释放内存
- 使用更短的音频切片

#### ❌ 问题3: 推理速度慢
**原因**: CPU 推理 vs GPU 推理  
**解决方案**:
- 确保使用 MPS 后端 (PyTorch 2.0+)
- 减少输出音频长度
- 使用预生成的批量脚本

### 5.3 质量评估标准

**优秀配音特征**:
- [ ] 发音清晰准确
- [ ] 语调自然流畅  
- [ ] 情感表达符合角色
- [ ] 无机械感或失真
- [ ] 与参考音频风格一致

**武松配音质量**: ⚠️ 中等 (需要调整参考音频和参数)

---

## 📊 第六部分：工作流集成

### 6.1 与 Dify + ComfyUI 集成

**完整 AI 短剧生产流程**:
```
Dify 剧本生成 → 提取台词 → GPT-SoVITS 配音 → ComfyUI 视频生成 → FFmpeg 合成
```

**自动化脚本示例**:
```python
# ai_drama_pipeline.py
def generate_complete_scene(scene_data):
    # 1. 从 Dify 获取剧本
    lines = extract_dialogue(scene_data)
    
    # 2. 批量生成配音
    audio_files = []
    for i, line in enumerate(lines):
        audio = gpt_sovits_tts(
            text=line,
            ref_audio="wusong_reference.m4a",
            gpt_model="wusong_v3_gpt.ckpt",
            sovits_model="wusong_v3_sovits.pth"
        )
        audio_files.append(audio)
    
    # 3. 生成视频 (ComfyUI)
    video_clip = comfyui_generate(scene_data)
    
    # 4. 合成最终视频
    final_video = ffmpeg_mux(video_clip, audio_files)
    
    return final_video
```

### 6.2 文件管理规范

**目录结构**:
```
~/GPT-SoVITS/
├── raw_data/           # 原始录音
├── raw/                # 预处理后数据
├── logs/               # 训练日志
├── GPT_weights/        # GPT 模型
├── SoVITS_weights/     # SoVITS 模型  
├── output/             # 生成的配音
└── webui.py            # WebUI 入口
```

---

## 🚀 快速开始命令

```bash
# 1. 启动 WebUI
cd ~/GPT-SoVITS && python webui.py

# 2. 访问 WebUI
open http://127.0.0.1:9874

# 3. 批量生成武松配音
python ~/GPT-SoVITS/generate_wusong_13_real.py

# 4. 检查输出
ls ~/GPT-SoVITS/output/wusong_real/

# 5. 测试单句生成
curl -X POST http://127.0.0.1:9874/tts \
  -H "Content-Type: application/json" \
  -d '{"text":"武松打虎！","text_lang":"zh","ref_audio_path":"/Users/hokeli/GPT-SoVITS/raw_data/wusong_2_武松.m4a","prompt_text":"景阳冈上酒气冲天。","prompt_lang":"zh"}' \
  --output test.wav
```

---

> **💡 提示**: 武松模型已训练完成，可直接用于推理。如需重新训练，请先备份现有模型。建议使用 WebUI 进行交互式调试，再使用脚本进行批量处理。