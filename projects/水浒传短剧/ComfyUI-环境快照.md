---
title: "ComfyUI-环境快照"
created: 2026-04-24
updated: 2026-04-24
tags: [项目, 项目/短剧]
status: draft
---
# 📸 ComfyUI 环境快照

> **拍摄时间**: 2026-04-22 04:00 PDT
> **用途**: 快速恢复环境配置

---

## 🖥️ 系统环境

| 项目 | 值 |
|------|-----|
| 硬件 | Mac M1 Max (32GB RAM) |
| macOS | 25.4.0 (Darwin arm64) |
| Python | 3.14.0 (Homebrew) |
| PyTorch | 2.x (MPS) |
| 磁盘 | 318GB 总量 / 12GB 已用 (4%) |

---

## 🎬 ComfyUI

| 项目 | 值 |
|------|-----|
| 版本 | 0.19.1 |
| 位置 | ~/ComfyUI/ |
| 启动命令 | `cd ~/ComfyUI && python3 main.py --listen 127.0.0.1 --port 8188` |
| MPS 补丁 | 已应用 (float64→float32) |

### 已安装节点
| 节点 | 位置 | 用途 |
|------|------|------|
| ComfyUI-WanVideoWrapper | ~/ComfyUI/custom_nodes/ComfyUI-WanVideoWrapper/ | Wan2.1 支持 |
| ComfyUI-AnimateDiff-Evolved | ~/ComfyUI/custom_nodes/ComfyUI-AnimateDiff-Evolved/ | 动画生成 |
| ComfyUI-VideoHelperSuite | ~/ComfyUI/custom_nodes/ComfyUI-VideoHelperSuite/ | 视频输出 |
| wanvideowrapper_qq | ~/ComfyUI/custom_nodes/wanvideowrapper_qq/ | 额外功能 |
| ComfyUI-Manager | ~/ComfyUI/custom_nodes/ComfyUI-Manager/ | 节点管理 |

### 保留模型清单 (34.6GB)
| 模型 | 路径 | 大小 | 来源 |
|------|------|------|------|
| CLIP ViT-H-14 | ~/ComfyUI/models/clip_vision/clip-vit-h-14-laion2b_s32b_b79k.bin | 3.7GB | laion/CLIP-ViT-H-14-laion2B-s32B-b79K |
| CLIP 336 | ~/ComfyUI/models/clip_vision/clip-vit-large-patch14-336.bin | 1.6GB | 内置 |
| SVD-XT | ~/ComfyUI/models/checkpoints/svd_xt.safetensors | 8.9GB | stabilityai/stable-video-diffusion-img2vid-xt |
| T5 Encoder | ~/ComfyUI/models/text_encoders/models_t5_umt5-xxl-enc-bf16.pth | 11GB | HuggingFace |
| T5 ComfyUI | ~/ComfyUI/models/text_encoders/umt5_xxl_comfyui.pth | 11GB | ComfyUI 版 |
| VAE | ~/ComfyUI/models/vae/Wan2.1_VAE.pth | ~500MB | Wan2.1 包内 |

### 已清理模型
| 模型 | 原大小 | 清理原因 |
|------|--------|----------|
| wan2.1_t2v_14B_bf16.safetensors | 26GB | Mac MPS 无法运行 |
| wan2.1-t2v-1.3B/ (含 T5) | 16.3GB | Mac MPS 采样卡死 |
| **合计释放** | **42.3GB** | |

### 待决策
- [ ] T5 编码器去重 (umt5_xxl_comfyui.pth vs models_t5_umt5-xxl-enc-bf16.pth)
- [ ] SVD-XT 移至外置硬盘 (8.9GB)
- [ ] CLIP 336 删除 (与 ViT-H-14 功能重复，1.6GB)

---

## 🎙️ GPT-SoVITS

| 项目 | 值 |
|------|-----|
| 版本 | V3 |
| 位置 | ~/GPT-SoVITS/ |
| Python | 3.10.13 (pyenv) |
| API 端口 | 9880 |
| WebUI 端口 | 9874 |
| 守护进程 | ~/Library/LaunchAgents/com.user.gptsovits.s2train.plist |

### 训练进度
| 项目 | 值 |
|------|-----|
| 角色 | 武松 (Wu Song) |
| S1 状态 | ✅ 完成 (100 epochs, top_3_acc: 1.000) |
| S2 状态 | 🔄 Epoch 11 (训练中) |
| 配置 | ~/GPT-SoVITS/logs/wusong_v3/s2_config.json |
| 参考音频 | ~/GPT-SoVITS/raw_data/原-武松-01.wav |

### V3 训练配置关键点
```json
{
  "train": {
    "epochs": 100,
    "batch_size": 1,
    "learning_rate": 1e-4,
    "save_every_epoch": 10,
    "optim": {
      "lr_end": 1e-5,
      "betas": [0.9, 0.98],
      "eps": 1e-9
    }
  },
  "data": {
    "sampling_rate": 32000,
    "exp_dir": "/Users/hokeli/GPT-SoVITS/logs/wusong_v3"
  },
  "model": {
    "gin_channels": 512
  }
}
```

---

## ☁️ Replicate 云端

| 项目 | 值 |
|------|-----|
| Token | r8_0XnZ4jH...43ed |
| 配置文件 | ~/AI_Short_Drama_Pipeline/config.json |
| 账户 | ericli228 (MagicPocket) |
| 余额 | $5.00 (处理中) |
| 可用模型 | seedance-2.0-fast, hailuo-02, hunyuan-video |

---

## 🔧 关键补丁文件

| 文件 | 修改内容 |
|------|----------|
| comfy/k_diffusion/utils.py | float64→float32 (MPS) |
| ComfyUI-WanVideoWrapper/wanvideo/modules/model.py | 4处 RoPE float64→float32 |
| ComfyUI-WanVideoWrapper/wanvideo/schedulers/fm_solvers_unipc.py | sigmas dtype |
| ComfyUI-WanVideoWrapper/wanvideo/schedulers/__init__.py | _apply_custom_sigmas MPS |

**恢复补丁**:
```bash
cd ~/ComfyUI && git checkout -- comfy/k_diffusion/utils.py
cd custom_nodes/ComfyUI-WanVideoWrapper && git checkout -- wanvideo/modules/model.py wanvideo/schedulers/
```

---

## 📂 关键路径速查

| 路径 | 用途 |
|------|------|
| ~/AI_Short_Drama_Pipeline/ai_drama_pipeline.py | 主 Pipeline 代码 |
| ~/AI_Short_Drama_Pipeline/config.json | Replicate 配置 |
| ~/AI_Short_Drama_Pipeline/scripts/daily_report.sh | 每日报告脚本 |
| ~/GPT-SoVITS/scripts/start_s2_training.sh | S2 训练启动脚本 |
| ~/GPT-SoVITS/logs/wusong_v3/ | 训练日志和配置 |
| ~/knowledge-base/AI短剧制作/Wan2.1-Workflow-Config.md | Obsidian 主文档 |
| ~/Backups/ComfyUI-20260422/ | 配置备份 |

---

*Last updated: 2026-04-22 04:00 PDT*
