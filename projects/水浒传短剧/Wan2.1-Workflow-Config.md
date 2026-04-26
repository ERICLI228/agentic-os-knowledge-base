---
title: "Wan2.1-Workflow-Config"
created: 2026-04-24
updated: 2026-04-24
tags: [项目, 项目/短剧]
status: draft
---
# 🎬 Wan2.1 Workflow Config & Backup Guide

> **Created**: 2026-04-22
> **Updated**: 2026-04-22 03:30 PDT
> **Purpose**: Backup configuration + Replicate 云端迁移记录
> **Status**: Mac 本地生成不可行，已切换 Replicate 云端 API

---

## 📋 系统架构

| 组件 | 方案 | 状态 |
|------|------|------|
| 视频生成 | Replicate 云端 API | ✅ 已配置，待购买 Credit |
| TTS 语音 | GPT-SoVITS 本地 | 🔄 S2 训练中 (Epoch 11) |
| 视频拼接 | FFmpeg (Mac) | ✅ 可用 |
| 流水线 | ai_drama_pipeline.py | ✅ 已重写 |

---

## 🔧 Replicate 云端集成

### API 配置
- **Token**: `r8_0XnZ4jH...43ed`
- **配置文件**: `~/AI_Short_Drama_Pipeline/config.json`
- **环境变量**: `REPLICATE_API_TOKEN` (已写入 ~/.zshrc)
- **账户**: ericli228 / MagicPocket

### ⚠️ 阻塞事项: 需要购买 Credit
- $5 已充值但**未购买 Credit**
- 请访问: https://replicate.com/account/billing#billing
- 购买后等待几分钟生效

### 可用视频模型 (购买 Credit 后)
| 模型 | 类型 | 版本 ID | 预估成本 |
|------|------|---------|----------|
| bytedance/seedance-2.0-fast | t2v+i2v | 4db424d5... | ~$0.02/次 |
| minimax/hailuo-02 | t2v+i2v | baaadb88... | ~$0.02/次 |
| tencent/hunyuan-video | t2v | 6c9132ae... | ~$0.05/次 |

### 预算控制
- 总预算: $5
- Pipeline 限制: $4.5 (留 $0.5 余量)
- 预估单次: $0.02 (seedance-2.0-fast)
- 可生成视频数: ~225 次

---

## 📁 大模型文件清单 (待决策)

### 🔴 大于 5GB 的文件 (共 62GB)
| 文件 | 大小 | 用途 | 可删除? |
|------|------|------|---------|
| `wan2.1_t2v_14B_bf16.safetensors` | **26GB** | Wan2.1 14B | ✅ Mac 用不了 |
| `models_t5_umt5-xxl-enc-bf16.pth` (text_encoders) | **11GB** | T5 编码器 | ⚠️ SVD 可能需要 |
| `umt5_xxl_comfyui.pth` | **11GB** | T5 编码器 (重复?) | ⚠️ 检查是否重复 |
| `svd_xt.safetensors` | **8.9GB** | SVD-XT | ⚠️ 云端不用但可能备用 |
| `diffusion_pytorch_model.safetensors` (1.3B) | **5.3GB** | Wan2.1 1.3B | ✅ Mac 用不了 |
| `models_t5_umt5-xxl-enc-bf16.pth` (1.3B目录) | **11GB** | T5 编码器 (重复?) | ⚠️ 检查是否重复 |

### 建议操作
1. **立即删除**: `wan2.1_t2v_14B_bf16.safetensors` (26GB) - Mac 完全用不了
2. **检查重复**: 两个 T5 编码器是否相同?
3. **移至外置硬盘**: SVD-XT checkpoint (8.9GB)
4. **暂保留**: 所有 <5GB 的文件

**预计释放空间**: 26-50GB

---

## 🛠️ 本地补丁记录

### MPS 兼容性补丁 (已应用但无法解决问题)
| 文件 | 修改内容 |
|------|----------|
| `comfy/k_diffusion/utils.py` | float64→float32 |
| `ComfyUI-WanVideoWrapper/wanvideo/modules/model.py` | 4处 RoPE |
| `ComfyUI-WanVideoWrapper/wanvideo/schedulers/*` | sigmas dtype |

### CLIP 模型
- ✅ `clip-vit-h-14-laion2b_s32b_b79k.bin` (3.7GB) 已下载
- ⚠️ `clip-vit-large-patch14-336.bin` (1.6GB) 维度不兼容

---

## 📝 Pipeline 代码

- **主文件**: `~/AI_Short_Drama_Pipeline/ai_drama_pipeline.py` (已重写为 Replicate 版)
- **备份**: `ai_drama_pipeline.py.bak`
- **配置**: `config.json`
- **工作流**: `workflows/comfyui_*.json`

### 运行方式
```bash
cd ~/AI_Short_Drama_Pipeline
python ai_drama_pipeline.py --story "武松打虎" --episode 1
```

---

## 💾 备份位置
- 配置备份: `~/Backups/ComfyUI-20260422/`
- 备份脚本: `scripts/backup-comfyui.sh`

---

*Last updated: 2026-04-22 03:30 PDT*
