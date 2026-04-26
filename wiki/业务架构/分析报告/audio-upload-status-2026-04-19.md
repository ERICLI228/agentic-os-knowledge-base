---
title: "audio-upload-status-2026-04-19"
created: 2026-04-24
updated: 2026-04-24
tags: [架构/业务, 短剧]
status: draft
---
# 参考音频上传状态报告

**时间**: 2026-04-19 12:10 PDT

---

## 🤖 自动化尝试结果

### Selenium 脚本执行结果

```
启动浏览器...
访问 http://localhost:9874...
✅ 页面加载完成

📸 已保存初始截图

寻找 Inference 标签页...
找到 21 个标签元素

📸 已保存截图

寻找文件上传控件...
找到 0 个文件上传控件 ❌

寻找参考文本输入框...
找到 14 个文本输入框
✅ 已填写参考文本：景阳冈上酒气冲天。

📸 已保存最终截图
```

### 问题分析

**文件上传控件**: ❌ 未找到 (0 个)
- GPT-SoVITS WebUI 可能使用自定义上传组件
- 不是标准的 `<input type="file">` 元素
- 需要 JavaScript 点击触发

**文本输入框**: ✅ 找到 14 个
- 已成功填写参考文本

### 截图位置

```
/tmp/webui_initial.png    - 初始页面
/tmp/webui_after_tab.png  - 切换标签后
/tmp/webui_final.png      - 填写文本后
```

---

## ✅ 解决方案：手动上传

### 请在 WebUI 界面手动操作

**地址**: http://localhost:9874/

### 步骤

1. **进入「1C-Inference」标签页**

2. **选择模型**:
   - GPT: `wusong_v3_gpt.ckpt`
   - SoVITS: `wusong_v3_sovits.pth`

3. **上传参考音频**:
   - 找到音频上传区域 (可能有 📎 或 🎤 图标)
   - 点击上传按钮
   - 选择：`/Users/hokeli/GPT-SoVITS/raw_data/wusong_2_武松.m4a`

4. **确认参考文本**:
   - 应该已自动填写：`景阳冈上酒气冲天。`
   - 如未填写，手动输入

5. **生成 13 句配音** (逐句)

---

## 📊 当前状态

| 组件 | 状态 | 说明 |
|------|------|------|
| WebUI 服务 | ✅ 运行中 | 端口 9874 |
| 参考文本 | ✅ 已填写 | Selenium 自动填写 |
| 参考音频 | ❌ 未上传 | 自动化失败，需手动 |
| 13 句配音 | ⏳ 待生成 | 待音频上传后 |
| 音频后处理 | ⏳ 待执行 | 自动监控 output/ |
| 视频合成 | ⏳ 待执行 | assemble.sh 已就绪 |

---

## 🎯 下一步

**用户操作**:
1. 访问 http://localhost:9874/
2. 手动上传参考音频 `wusong_2_武松.m4a`
3. 生成 13 句配音

**自动执行** (音频生成后):
1. 监控 `/Users/hokeli/GPT-SoVITS/output/` 目录
2. 搬运音频到 `AI_Short_Drama_Pipeline/assets/audio/`
3. 重命名为 `vo_01.wav` ~ `vo_13.wav`
4. 运行 `assemble.sh` 合成视频

---

*自动化部分成功，参考文本已填写，音频需手动上传*
