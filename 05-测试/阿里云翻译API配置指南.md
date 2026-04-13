# 阿里云翻译API配置指南

## 步骤1：开通阿里云机器翻译服务

1. 打开 **阿里云机器翻译** 产品页面：
   https://ai.aliyun.com/nlp/trans

2. 点击「立即开通」或「免费开通」
   - ✅ **每月 100 万字符免费额度**（足够初期使用）

3. 使用支付宝账号扫码登录

---

## 步骤2：获取 AccessKey（API密钥）

1. 登录阿里云控制台
2. 点击右上角 **头像** → **AccessKey管理**
3. 选择「子用户 AccessKey」或「主账号 AccessKey」
4. 如果第一次创建：
   - 点击「创建 AccessKey」
   - 下载并保存好 **AccessKeyId** 和 **AccessKeySecret**
5. **重要**：需要给这个AccessKey授权「机器翻译」权限

---

## 步骤3：在 OpenClaw 中配置

你需要提供以下信息：

| 配置项 | 说明 | 你的值 |
|--------|------|--------|
| AccessKeyId | 访问ID | ? |
| AccessKeySecret | 访问密钥 | ? |

---

## 步骤4：验证翻译是否可用

开通后可以测试：
```bash
curl -X POST "https://mt.cn-hangzhou.aliyuncs.com/" \
  -d "Action=TranslateBatch" \
  -d "FormatType=text" \
  -d "SourceLanguage=zh" \
  -d "TargetLanguage=en" \
  -d "SourceText=你好" \
  -d "AccessKeyId=你的ID" \
  -d "SignatureMethod=HMAC-SHA1" \
  -d "SignatureVersion=1.0" \
  -d "Timestamp=2026-03-28T12:00:00Z" \
  -d "Signature=..."
```

---

## ⚠️ 注意事项

1. **保存好 AccessKey**：泄露后及时在阿里云控制台禁用
2. **免费额度**：每月100万字符，超出后收费
3. **支持语言**：中文、英文、印尼语、泰语、越南语、马来语 等

---

## 你需要做的

1. **开通机器翻译**：https://ai.aliyun.com/nlp/trans
2. **获取 AccessKeyId 和 AccessKeySecret**
3. **把这两个值发给我**

我来帮你配置到 OpenClaw 和 sea5-localization Skill 中。

---

*当你开通好了，把 AccessKeyId 发给我，我继续指导下一步。*