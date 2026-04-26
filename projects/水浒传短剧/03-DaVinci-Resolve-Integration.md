---
title: "03-DaVinci-Resolve-Integration"
created: 2026-04-24
updated: 2026-04-24
tags: [项目, 项目/短剧]
status: draft
---
# 🎬 DaVinci Resolve 集成到 AI 短剧工作流指南

> **目标**: 将 DaVinci Resolve 的专业级字幕、调色、合成能力集成到 Dify + ComfyUI + GPT-SoVITS 自动化流程中

---

## 🔧 第一步：DaVinci Resolve 安装与配置

### 1.1 下载与安装
```bash
# DaVinci Resolve 免费版下载
# 官网: https://www.blackmagicdesign.com/products/davinciresolve/

# macOS 安装步骤:
# 1. 下载 DaVinci Resolve 18.6+ (免费版)
# 2. 拖拽到 Applications 文件夹
# 3. 首次启动时允许系统权限

# 验证安装
ls "/Applications/DaVinci Resolve.app"
```

### 1.2 命令行工具启用
DaVinci Resolve 提供强大的命令行渲染功能：

**macOS 路径**:
```bash
# Resolve 命令行工具位置
/Applications/DaVinci\ Resolve/DaVinci\ Resolve.app/Contents/MacOS/Resolve

# Fusion 命令行渲染器
/Applications/DaVinci\ Resolve/DaVinci\ Resolve.app/Contents/MacOS/Fusion
```

**创建快捷方式**:
```bash
# 添加到 PATH
echo 'export PATH="/Applications/DaVinci Resolve.app/Contents/MacOS:$PATH"' >> ~/.zshrc
source ~/.zshrc

# 验证
which Resolve
```

---

## 📂 第二步：项目文件结构设计

### 2.1 自动化友好的目录结构
```
~/AI_Short_Drama_Pipeline/
├── input/                 # 输入素材
│   ├── video_clips/       # ComfyUI 生成的视频片段
│   ├── audio_files/       # GPT-SoVITS 生成的配音
│   └── scripts/           # Dify 生成的剧本
├── resolve_projects/      # DaVinci Resolve 项目
│   ├── templates/         # 项目模板
│   └── auto_generated/    # 自动生成的项目
├── output/                # 最终输出
│   ├── drafts/            # 初稿
│   └── final/             # 成品
└── automation/            # 自动化脚本
    ├── create_resolve_project.py
    ├── add_subtitles.py
    └── render_final_video.py
```

### 2.2 武松打虎项目示例
```bash
# 创建项目目录
mkdir -p ~/AI_Short_Drama_Pipeline/resolve_projects/auto_generated/wusong_fight_tiger

# 准备输入文件
cp ~/ComfyUI/output/wusong_scene_*.webp ~/AI_Short_Drama_Pipeline/input/video_clips/
cp ~/GPT-SoVITS/output/wusong_real/*.wav ~/AI_Short_Drama_Pipeline/input/audio_files/
cp ~/AI_Short_Drama_Pipeline/scripts/wusong_script.json ~/AI_Short_Drama_Pipeline/input/scripts/
```

---

## 🤖 第三步：自动化脚本开发

### 3.1 创建 DaVinci Resolve 项目脚本

**脚本**: `~/AI_Short_Drama_Pipeline/automation/create_resolve_project.py`

```python
#!/usr/bin/env python3
"""
自动创建 DaVinci Resolve 项目并导入素材
"""

import os
import json
import subprocess
from pathlib import Path

def create_resolve_project(project_name, video_dir, audio_dir, script_file):
    """创建 Resolve 项目并导入素材"""
    
    # 1. 读取剧本数据
    with open(script_file, 'r', encoding='utf-8') as f:
        script_data = json.load(f)
    
    # 2. 构建项目路径
    project_path = f"~/AI_Short_Drama_Pipeline/resolve_projects/auto_generated/{project_name}"
    os.makedirs(project_path, exist_ok=True)
    
    # 3. 生成 Fusion 脚本 (用于自动导入)
    fusion_script = generate_fusion_import_script(
        video_dir, audio_dir, script_data, project_path
    )
    
    # 4. 执行 Resolve 命令行创建项目
    cmd = [
        "/Applications/DaVinci Resolve.app/Contents/MacOS/Resolve",
        "-script", fusion_script,
        "-project", project_name
    ]
    
    try:
        result = subprocess.run(cmd, capture_output=True, text=True, timeout=300)
        if result.returncode == 0:
            print(f"✅ Resolve 项目 '{project_name}' 创建成功!")
            return True
        else:
            print(f"❌ 创建失败: {result.stderr}")
            return False
    except subprocess.TimeoutExpired:
        print("⚠️  创建超时，可能需要手动检查")
        return False

def generate_fusion_import_script(video_dir, audio_dir, script_data, project_path):
    """生成 Fusion 脚本用于导入素材"""
    # 这里会生成一个 .comp 文件或 Lua 脚本
    # 详细实现取决于 Resolve 的脚本 API
    pass

if __name__ == "__main__":
    create_resolve_project(
        "wusong_fight_tiger_v1",
        "~/AI_Short_Drama_Pipeline/input/video_clips",
        "~/AI_Short_Drama_Pipeline/input/audio_files", 
        "~/AI_Short_Drama_Pipeline/input/scripts/wusong_script.json"
    )
```

### 3.2 自动字幕生成脚本

**脚本**: `~/AI_Short_Drama_Pipeline/automation/add_subtitles.py`

```python
#!/usr/bin/env python3
"""
基于剧本自动生成字幕并添加到 Resolve 项目
"""

import json
import os

def generate_subtitle_timeline(script_file, output_format="srt"):
    """从剧本生成时间轴字幕"""
    
    with open(script_file, 'r', encoding='utf-8') as f:
        script_data = json.load(f)
    
    subtitles = []
    current_time = 0.0
    
    for scene in script_data.get('scenes', []):
        for dialogue in scene.get('dialogue', []):
            # 计算台词持续时间 (基于字符数估算)
            text = dialogue['line']
            duration = max(2.0, len(text) * 0.15)  # 最少2秒，每字符0.15秒
            
            subtitle_entry = {
                'start': current_time,
                'end': current_time + duration,
                'text': text,
                'character': dialogue['character']
            }
            subtitles.append(subtitle_entry)
            current_time += duration + 0.5  # 0.5秒间隔
    
    # 生成 SRT 格式
    if output_format == "srt":
        srt_content = convert_to_srt(subtitles)
        return srt_content
    elif output_format == "resolve":
        # 生成 Resolve 字幕格式
        return convert_to_resolve_subtitles(subtitles)
    
    return subtitles

def convert_to_srt(subtitles):
    """转换为 SRT 格式"""
    srt_lines = []
    for i, sub in enumerate(subtitles, 1):
        start_time = format_time(sub['start'])
        end_time = format_time(sub['end'])
        srt_lines.extend([
            str(i),
            f"{start_time} --> {end_time}",
            sub['text'],
            ""
        ])
    return "\n".join(srt_lines)

def format_time(seconds):
    """格式化时间为 SRT 格式"""
    hours = int(seconds // 3600)
    minutes = int((seconds % 3600) // 60)
    secs = int(seconds % 60)
    millis = int((seconds % 1) * 1000)
    return f"{hours:02d}:{minutes:02d}:{secs:02d},{millis:03d}"

if __name__ == "__main__":
    srt_content = generate_subtitle_timeline(
        "~/AI_Short_Drama_Pipeline/input/scripts/wusong_script.json"
    )
    
    with open("~/AI_Short_Drama_Pipeline/output/subtitles.srt", 'w', encoding='utf-8') as f:
        f.write(srt_content)
    
    print("✅ 字幕文件生成完成!")
```

### 3.3 自动渲染脚本

**脚本**: `~/AI_Short_Drama_Pipeline/automation/render_final_video.py`

```python
#!/usr/bin/env python3
"""
自动渲染最终视频
"""

import subprocess
import os

def render_resolve_project(project_name, output_path, preset="H.264 Master"):
    """渲染 Resolve 项目"""
    
    cmd = [
        "/Applications/DaVinci Resolve.app/Contents/MacOS/Resolve",
        "-render",
        "-project", project_name,
        "-output", output_path,
        "-preset", preset,
        "-framerate", "25",
        "-resolution", "1920x1080"
    ]
    
    try:
        print(f"🎬 开始渲染项目: {project_name}")
        result = subprocess.run(cmd, capture_output=True, text=True, timeout=3600)
        
        if result.returncode == 0:
            print(f"✅ 渲染完成! 输出: {output_path}")
            return True
        else:
            print(f"❌ 渲染失败: {result.stderr}")
            return False
            
    except subprocess.TimeoutExpired:
        print("⚠️  渲染超时 (超过1小时)")
        return False

if __name__ == "__main__":
    render_resolve_project(
        "wusong_fight_tiger_v1",
        "~/AI_Short_Drama_Pipeline/output/final/wusong_fight_tiger_final.mp4"
    )
```

---

## 🔗 第四步：完整工作流集成

### 4.1 主控脚本

**脚本**: `~/AI_Short_Drama_Pipeline/ai_drama_pipeline_with_resolve.py`

```python
#!/usr/bin/env python3
"""
完整的 AI 短剧生产流水线 (包含 DaVinci Resolve)
"""

import subprocess
import time
import os

def main():
    """主工作流"""
    print("🎬 启动 AI 短剧全自动生产流水线...")
    
    # 步骤 1: Dify 生成剧本
    print("1️⃣  Dify 生成剧本...")
    script_data = call_dify_script_generator("武松打虎第2集 - 复仇爽剧")
    
    # 步骤 2: ComfyUI 生成视频片段
    print("2️⃣  ComfyUI 生成视频...")
    video_clips = generate_video_scenes(script_data)
    
    # 步骤 3: GPT-SoVITS 生成配音
    print("3️⃣  GPT-SoVITS 生成配音...")
    audio_files = generate_voice_over(script_data)
    
    # 步骤 4: 创建 DaVinci Resolve 项目
    print("4️⃣  创建 DaVinci Resolve 项目...")
    create_resolve_project("wusong_fight_tiger_auto", video_clips, audio_files, script_data)
    
    # 步骤 5: 自动生成字幕
    print("5️⃣  生成字幕...")
    generate_subtitles(script_data)
    
    # 步骤 6: 自动渲染最终视频
    print("6️⃣  渲染最终视频...")
    final_video = render_final_video("wusong_fight_tiger_auto")
    
    print(f"🎉 全流程完成! 最终视频: {final_video}")

def call_dify_script_generator(story_idea):
    """调用 Dify API 生成剧本"""
    # 实现 Dify API 调用
    pass

def generate_video_scenes(script_data):
    """调用 ComfyUI 生成视频片段"""
    # 实现 ComfyUI API 调用
    pass

def generate_voice_over(script_data):
    """调用 GPT-SoVITS 生成配音"""
    # 实现 GPT-SoVITS API 调用  
    pass

# ... 其他函数实现

if __name__ == "__main__":
    main()
```

### 4.2 工作流执行命令

```bash
# 完整自动化执行
cd ~/AI_Short_Drama_Pipeline
python ai_drama_pipeline_with_resolve.py

# 分步骤执行
# 1. 生成字幕
python automation/add_subtitles.py

# 2. 创建 Resolve 项目  
python automation/create_resolve_project.py

# 3. 渲染最终视频
python automation/render_final_video.py
```

---

## ⚡ 第五步：性能优化与最佳实践

### 5.1 Resolve 项目模板
创建预配置的 Resolve 项目模板，包含：
- 预设的色彩分级 LUT
- 字幕样式模板
- 音频混音预设
- 导出预设（H.264, ProRes 等）

### 5.2 批处理优化
```bash
# 并行处理多个场景
for scene in scenes:
    python process_scene.py --scene $scene &
    
# 等待所有完成
wait

# 最终合成
python render_final.py
```

### 5.3 错误处理与恢复
```python
# 在脚本中添加检查点
def checkpoint_save(state, filename):
    with open(filename, 'w') as f:
        json.dump(state, f)

def checkpoint_load(filename):
    if os.path.exists(filename):
        with open(filename, 'r') as f:
            return json.load(f)
    return None
```

---

## 📊 第六步：质量控制检查清单

### 6.1 视频质量
- [ ] 分辨率达到 1080p
- [ ] 帧率稳定 25fps
- [ ] 色彩分级一致
- [ ] 无压缩伪影

### 6.2 音频质量  
- [ ] 音量标准化 (-6dB 到 -3dB)
- [ ] 无爆音或失真
- [ ] 背景噪音控制
- [ ] 声音清晰度

### 6.3 字幕质量
- [ ] 时间轴准确同步
- [ ] 字体大小适中
- [ ] 位置不遮挡重要画面
- [ ] 样式符合品牌规范

---

## 🚀 快速开始步骤

```bash
# 1. 安装 DaVinci Resolve (如果未安装)
# 下载地址: https://www.blackmagicdesign.com/products/davinciresolve/

# 2. 创建工作目录
mkdir -p ~/AI_Short_Drama_Pipeline/{input,output,resolve_projects,automation}

# 3. 复制自动化脚本
cp automation_scripts/* ~/AI_Short_Drama_Pipeline/automation/

# 4. 测试字幕生成
python ~/AI_Short_Drama_Pipeline/automation/add_subtitles.py

# 5. 集成到主工作流
# 修改 ai_drama_pipeline.py 包含 Resolve 步骤
```

---

> **💡 提示**: DaVinci Resolve 的命令行功能在免费版中有限制，某些高级功能可能需要 Studio 版本。但对于基本的字幕添加、色彩分级和渲染，免费版完全足够。建议先用简单项目测试自动化流程，再应用到复杂制作中。