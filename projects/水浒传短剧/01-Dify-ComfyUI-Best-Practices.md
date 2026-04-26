---
title: "01-Dify-ComfyUI-Best-Practices"
created: 2026-04-24
updated: 2026-04-24
tags: [项目, 项目/短剧]
status: draft
---
# 🎬 Dify + ComfyUI 行业最佳实践操作指引

> **适用场景**: AI 短剧自动化生产（武松打虎案例）  
> **系统状态**: ✅ Dify (http://localhost:9000) + ✅ ComfyUI (http://127.0.0.1:8188) + ✅ Wan2.1 14B 模型

---

## 📋 整体工作流架构

```
剧本创意 → Dify 剧本生成 → ComfyUI 视频生成 → 音频合成 → 最终视频
     ↑              ↓               ↓             ↓
  人工输入      结构化输出      IPAdapter角色一致性   GPT-SoVITS配音
```

---

## 🔧 第一步：Dify 剧本生成器配置

### 1.1 登录 Dify
- **地址**: http://localhost:9000
- **账号**: admin@dify.com / Admin123456

### 1.2 导入剧本生成工作流
```bash
# 工作流文件位置
~/AI_Short_Drama_Pipeline/workflows/dify_script_generator.yaml
```

**导入步骤**:
1. 进入 Dify 控制台 → **应用** → **创建工作流**
2. 点击 **导入** → 选择 `dify_script_generator.yaml`
3. 配置模型提供者（建议使用 MiniMax-M2.5 或 Qwen3.5-plus）

### 1.3 工作流参数说明
| 参数 | 示例值 | 说明 |
|------|--------|------|
| `故事创意` | "武松打虎第2集 - 复仇爽剧" | 核心剧情概念 |
| `集数` | 2 | 剧集编号 |
| `时长目标` | 60 | 目标视频时长（秒） |
| `风格` | "中国神话水墨画风" | 视觉风格选择 |

---

## 🎨 第二步：ComfyUI 视频生成配置

### 2.1 准备角色参考图
```bash
# 参考图位置
~/AI_Short_Drama_Pipeline/assets/characters/wusong/
# 或直接放入 ComfyUI 输入目录
~/ComfyUI/input/wusong_reference.png
```

**参考图要求**:
- 清晰正面人像
- 白底或简单背景
- 与剧本角色描述一致
- 尺寸建议: 512x512 或 1024x1024

### 2.2 加载武松工作流
```bash
# 工作流文件
~/AI_Short_Drama_Pipeline/workflows/comfyui_wusong_workflow.json
```

**加载步骤**:
1. 打开 ComfyUI: http://127.0.0.1:8188
2. 菜单 → **Load** → 选择 `comfyui_wusong_workflow.json`
3. 确认模型路径正确：
   - Wan2.1 14B: `wan2.1_t2v_14B_bf16.safetensors`
   - Wan2.1 I2V: `wan2.1_i2v_14B_720P_bf16.safetensors`

### 2.3 工作流关键节点说明

#### 🎯 **IPAdapter 角色一致性控制**（行业最佳实践）
- **作用**: 确保多镜头中角色外观一致
- **参数**: 
  - 模型: `PLUS (high strength)`
  - 权重: `0.8`
- **连接**: 参考图 → IPAdapter → 视频生成器

#### 🎥 **Wan2.1 视频生成设置**
| 参数 | 推荐值 | 说明 |
|------|--------|------|
| 分辨率 | 1280x720 | 720P 平衡质量/速度 |
| 帧率 | 25 fps | 标准视频帧率 |
| 时长 | 25 帧 | ~1秒片段 |
| CFG Scale | 6.0 | 控制生成稳定性 |
| 采样器 | uni_pc | Wan2.1 推荐采样器 |

---

## 🔄 第三步：端到端自动化流程

### 3.1 单场景生成示例
**输入**: 武松在景阳冈的场景描述

**Dify 输出示例**:
```json
{
  "scene_number": 1,
  "location": "景阳冈山林",
  "description": "武松身着白衣，手持哨棒，警惕地环顾四周",
  "characters": ["武松"],
  "dialogue": [{"character": "武松", "line": "这山中有猛虎出没，须得小心！"}],
  "duration_seconds": 8,
  "visual_prompt": "ancient Chinese warrior, white robe, heroic expression, bamboo forest, dramatic lighting"
}
```

**ComfyUI 提示词优化**:
```
masterpiece, best quality, ultra-detailed, ancient Chinese warrior Wusong, 
white robe with red sash, heroic expression, dynamic pose, traditional Chinese 
painting style, ink wash painting, bamboo forest background, dramatic lighting, 
cinematic composition, 8k resolution
```

### 3.2 批量场景处理
**策略**: 
1. 使用 Dify 生成完整剧本（多场景）
2. 为每个场景单独运行 ComfyUI 工作流
3. 使用不同随机种子确保画面多样性
4. 后期拼接所有片段

**自动化脚本**:
```python
# ~/AI_Short_Drama_Pipeline/ai_drama_pipeline.py
def generate_scene_video(scene_data, reference_image):
    # 1. 构建 ComfyUI API 请求
    prompt = build_wan21_prompt(scene_data)
    
    # 2. 调用 ComfyUI API
    video_clip = comfyui_api.generate(
        model="wan2.1_t2v_14B_bf16.safetensors",
        prompt=prompt,
        reference_image=reference_image,
        ipadapter_weight=0.8,
        frames=25,
        width=1280,
        height=720
    )
    
    return video_clip
```

---

## 🎵 第四步：音频与后期合成

### 4.1 音频生成选项
| 方案 | 优势 | 劣势 | 推荐场景 |
|------|------|------|----------|
| **GPT-SoVITS** | 声音克隆真实 | 需要训练数据 | 主角对话 |
| **MiniMax TTS** | 即时可用 | 声音通用 | 旁白/配角 |
| **原始录音** | 最真实 | 需手动切分 | 关键台词 |

### 4.2 字幕处理方案
由于 FFmpeg 限制，推荐以下方案：

**方案 A: ComfyUI 内置字幕**
- 在提示词中加入文字元素
- 适用于简单字幕

**方案 B: 后期软件添加**
- **剪映**: 自动语音识别 + 字幕
- **必映**: 专业字幕编辑
- **DaVinci Resolve**: 免费专业级

### 4.3 最终合成命令
```bash
# 合并视频片段
ffmpeg -f concat -i video_list.txt -c copy temp_combined.mp4

# 添加音频（假设已有配音文件）
ffmpeg -i temp_combined.mp4 -i final_audio.wav -c:v copy -c:a aac final_output.mp4

# 清理临时文件
rm temp_combined.mp4 video_list.txt
```

---

## ⚡ 性能优化建议（行业最佳实践）

### 5.1 硬件配置
| 组件 | 最低要求 | 推荐配置 |
|------|----------|----------|
| GPU | 16GB VRAM | 24GB+ VRAM (RTX 4090) |
| RAM | 32GB | 64GB+ |
| 存储 | NVMe SSD | RAID 0 NVMe |

### 5.2 生成参数优化
| 场景类型 | 分辨率 | 帧数 | CFG | 种子策略 |
|----------|--------|------|-----|----------|
| 特写镜头 | 720x1280 | 20 | 7.0 | 固定种子 |
| 全景镜头 | 1280x720 | 30 | 6.0 | 随机种子 |
| 动作镜头 | 1280x720 | 35 | 5.5 | 随机种子 |

### 5.3 批处理策略
- **并行生成**: 同时运行多个 ComfyUI 实例
- **队列管理**: 使用任务队列避免 GPU 过载
- **缓存机制**: 缓存常用提示词和参考图结果

---

## 📊 质量控制检查清单

### 6.1 角色一致性检查
- [ ] 多镜头中服装颜色一致
- [ ] 面部特征保持统一
- [ ] 身高比例协调
- [ ] 动作风格连贯

### 6.2 视频质量检查
- [ ] 无闪烁或跳帧
- [ ] 背景连贯无突变
- [ ] 光影效果自然
- [ ] 分辨率达到预期

### 6.3 音频同步检查
- [ ] 口型与音频匹配（如有人物说话）
- [ ] 音频无杂音或断点
- [ ] 音量平衡合适
- [ ] 字幕时间轴准确

---

## 🚀 快速开始命令

```bash
# 1. 启动服务（如果未运行）
docker-compose -f ~/difai/docker-compose.yaml up -d
cd ~/ComfyUI && python main.py --listen 127.0.0.1 --port 8188

# 2. 访问服务
open http://localhost:9000    # Dify
open http://127.0.0.1:8188   # ComfyUI

# 3. 测试简单工作流
curl -X POST http://127.0.0.1:8188/prompt \
  -H "Content-Type: application/json" \
  -d @~/AI_Short_Drama_Pipeline/test_comfyui_simple.json
```

---