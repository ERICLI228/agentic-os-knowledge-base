---
title: "API Keys"
created: 2026-04-24
updated: 2026-04-24
tags: [项目, 项目/短剧]
status: draft
---
# 🔑 API Keys 总览

> **更新时间**: 2026-04-22 04:45 PDT
> **用途**: 集中管理所有 AI 服务 API Key

---

## ☁️ 云端视频生成

### Replicate
| 项目 | 值 |
|------|-----|
| Token | `r8_****REDACTED****` |
| 状态 | ⏳ $5 处理中 (需购买 Credit) |
| 账户 | ericli228 / MagicPocket |
| 可用模型 | seedance-2.0-fast, hailuo-02, hunyuan-video |

### HeyGen (数字人视频)
| 项目 | 值 |
|------|-----|
| Key | `sk_****REDACTED****` |
| 状态 | ✅ 已验证 (Avatar: Aditya_public_2, Voice: Martin Li) |
| Avatar | 待确认 (API 返回 "avatar look not found") |
| Voice (中文男声) | `735c507fdc844be3b1528dd33f7dfb2a` (Martin Li) |
| Voice 总数 | 2325 个 |
| Avatar 总数 | 数百个 |

**可用 Avatar ID 示例** (需验证):
```
Aditya_public_2
Albert_public_3
Aiko_public
```

**可用中文 Voice ID**:
| ID | 名称 | 性别 |
|----|------|------|
| `735c507fdc844be3b1528dd33f7dfb2a` | Martin Li | male |
| `df1d72215c2647e2a53e51acbd14de79` | Karo Yang | male |
| `5700258d53664cecb4b21a8154856355` | James Gao | male |
| `961546a1be64458caa1386ff63dd5d5f` | Yunyang - Professional | male |
| `3b1633a466c44379bf8b5a2884727588` | YunJhe - Natural | male |
| `35f6b6ac010849d38cfc99dc25e0e4b3` | WanLung - Natural | male |
| `422dbf6b037648b69f663cd33b47007b` | Yunye - Calm | male |
| `ffdbe4de35d34391830da243f2b82e13` | Yunxi - Friendly | male |

---

## 🎙️ TTS / 语音

### GPT-SoVITS (本地)
| 项目 | 值 |
|------|-----|
| 端口 | 9880 (API) / 9874 (WebUI) |
| 状态 | ✅ 运行中 (守护进程) |
| 模型 | 武松 V3 (S1 100 epochs, S2 训练中) |
| 参考音频 | `~/GPT-SoVITS/raw_data/原-武松-01.wav` |
| 守护进程 | `~/Library/LaunchAgents/com.user.gptsovits.api_v2.plist` |

### MiniMax (云端 TTS)
| 项目 | 值 |
|------|-----|
| Key | `sk-****REDACTED****` |
| 状态 | ❌ 已失效 (token is unusable) |
| 13 句配音 | `~/GPT-SoVITS/output/minimax/wusong_mm_01~13.mp3` |

### HEYGUN (内容生成)
| 项目 | 值 |
|------|-----|
| Key | `sk_****REDACTED****` |
| 状态 | ✅ 已配置 |
| 用途 | 内容生成平台 |

### SiliconFlow CosyVoice
| 项目 | 值 |
|------|-----|
| Key | `sk-****REDACTED****` |
| 状态 | ⚠️ 余额 -$593.99 (超限) |

### 阿里云百炼
| Key | 用途 | 状态 |
|-----|------|------|
| `sk-b2122500f74347f4ae209ebf7df8d504` | 通用模型 | ✅ |
| `sk-3e7ed92bda1c49e59019aa1479a8b744` | TTS 语音 | ✅ |

---

## 📋 配置文件位置

| 文件 | 路径 |
|------|------|
| API Keys | `~/AI_Short_Drama_Pipeline/config.json` |
| 环境变量 | `~/.zshrc` |

---

## 📊 HeyGen API 测试结果

| 测试 | 结果 |
|------|------|
| Key 验证 | ✅ 有效 |
| Avatar 列表 | ✅ 返回数百个 |
| Voice 列表 | ✅ 返回 2325 个 |
| 视频生成 | ❌ "avatar look not found" |

**✅ 已验证**: Aditya_public_2 (男性) + Martin Li (中文男声) 测试成功！

---

*Last updated: 2026-04-22 04:45 PDT*
