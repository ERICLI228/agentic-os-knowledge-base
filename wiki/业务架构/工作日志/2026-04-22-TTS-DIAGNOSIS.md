---
title: "2026-04-22-TTS-DIAGNOSIS"
created: 2026-04-24
updated: 2026-04-24
tags: [日志, 架构/业务]
status: draft
---
# GPT-SoVITS TTS 诊断报告

**时间**: 2026-04-22 22:02 PDT
**目标**: 诊断并修复 AI 短剧生成质量（静态视频 + 配音截断）

---

## ✅ 成功启动的组件

| 组件 | 状态 | 说明 |
|------|------|------|
| replicate 模块 | ✅ 已安装 | Client/run 方法可用 |
| GPT-SoVITS API | ✅ 已启动 | PID 36647, 端口 9880 |
| 武松 V3 S2 权重 | ✅ 存在 | 4.3GB (s2G_wusong_v3_final.pth) |
| Replicate API Token | ✅ 已配置 | r8_0XnZ4jHRHn4GJeLT6... |
| HeyGen API Key | ✅ 已配置 | sk_V2_hgu_kOzloFJtrn... |

---

## ❌ 发现的核心问题

### 1. 武松 V3 缺少 S1 权重

**症状**: logs_s1_v3 目录不存在
**原因**: 只训练了 S2 模型，没有训练 S1 模型
**影响**: 无法完整使用武松 V3 定制语音

**权重状态**:
- S1: ❌ 不存在（需要训练或使用预训练）
- S2: ✅ 存在 (4.3GB)

---

### 2. TTS 精度不匹配（Float vs Half）

**症状**: `"expected scalar type Float but found Half"`
**原因**: v2 预训练模型使用 FP16 权重，CPU 推理需要 FP32
**当前配置**: `device: cpu, is_half: False`

**解决方案**:
- 方案A: 使用 GPU (CUDA/MPS) + `is_half=True`
- 方案B: 使用已经转换为 FP32 的权重
- 方案C: 使用 v3 版本模型（支持 CPU）

---

### 3. Replicate 账户余额不足

**状态**: $0.00
**影响**: 无法生成动态视频（T2V/SVD）
**解决方案**: 充值 Replicate 账户

---

### 4. HeyGen 账户余额不足

**状态**: HTTP 402 (Insufficient credit)
**影响**: 无法生成 Avatar 视频
**解决方案**: 充值 HeyGen 账户

---

## 🚀 推荐解决方案

### 方案1: 使用 GPU + 武松 V3 权重（最完整）

**步骤**:
1. 训练武松 V3 S1 模型（约 2-4 小时）
2. 启动 API 时设置 `device: cuda, is_half: True`
3. 使用完整的武松 V3 S1 + S2 组合

**优势**: 定制武松语音，最高质量
**劣势**: 需要 GPU + 训练时间

---

### 方案2: 使用预训练 v2 模型 + GPU（快速）

**步骤**:
1. 确保 Mac M1 MPS 可用（或使用 CUDA）
2. 启动 API 时设置 `device: mps, is_half: True`
3. 使用预训练 v2 模型

**优势**: 无需训练，快速启动
**劣势**: 无定制武松语音，需要 GPU

---

### 方案3: 使用 Edge-TTS（免费替代）

**步骤**:
1. 安装 edge-tts: `pip install edge-tts`
2. 使用 Microsoft 免费中文男声
3. 修改 Pipeline 使用 Edge-TTS

**优势**: 完全免费，支持多语言
**劣势**: 无定制武松语音

**示例**:
```bash
edge-tts --voice zh-CN-XiaoxiaoNeural --text "这景阳冈上果真有猛虎出没" --write-media /tmp/edge_tts.wav
```

---

### 方案4: 充值后继续使用 Replicate + HeyGen

**充值地址**:
- Replicate: https://replicate.com/pricing
- HeyGen: https://www.heygen.com/pricing

**成本估算**:
- Replicate T2V: ~$0.01-0.05/视频
- HeyGen Avatar: ~$0.075/秒

---

## 📈 下一步行动

### 立即可行（免费）:
1. ✅ 使用 Edge-TTS 替代 GPT-SoVITS（免费中文语音）
2. ✅ 使用 Pollinations AI 生成静态背景图
3. ✅ 用 FFmpeg 合成视频（静态图 + Edge-TTS 配音）

### 需要投入:
1. 训练武松 V3 S1 模型（约 2-4 小时）
2. 充值 Replicate（$5-10）用于动态视频
3. 充值 HeyGen（$10-20）用于 Avatar 视频

---

## ✅ 已验证可用的功能

| 功能 | 状态 | 输出 |
|------|------|------|
| Pollinations AI | ✅ 正常 | 1080x1920 图片（免费） |
| Edge-TTS | ✅ 正常 | 中文/印尼/越南/泰语（免费） |
| FFmpeg | ✅ 正常 | 视频合成（免费） |
| Local Free Pipeline | ✅ 正常 | 静态视频 + 配音（免费） |

---

**报告生成时间**: 2026-04-22 22:02 PDT
