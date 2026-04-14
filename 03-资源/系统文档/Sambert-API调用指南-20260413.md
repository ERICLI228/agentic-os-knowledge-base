# 🎭 阿里云Sambert配音API调用指南

> SDK已安装 ✅ | 需获取Token后可生成语音

---

## ✅ SDK安装成功

从日志确认：

```
Successfully installed aliyun-nls-0.0.1
```

**已安装的包**:
- ✅ aliyun-nls（语音合成SDK）
- ✅ oss2（阿里云存储）
- ✅ aliyun-python-sdk-core
- ✅ pycryptodome（加密）
- ✅ matplotlib（图表）

---

## ⏳ 下一步：获取Token

### 方式1：控制台临时Token（推荐首次）

**操作步骤**:

```
1. 登录智能语音交互控制台
   https://nls-portal.console.aliyun.com/

2. 点击首页 '获取临时AccessToken'

3. 复制Token（有效期通常24小时）
```

---

### 方式2：SDK自动生成Token

**Python代码**:

```python
from aliyun_nls import NlsToken

# 加载配置
config = load_config()

# 生成Token
token_generator = NlsToken(
    access_key_id=config['ALIYUN_ACCESS_KEY_ID'],
    access_key_secret=config['ALIYUN_ACCESS_KEY_SECRET']
)

token = token_generator.get_token()
print(f"Token: {token}")
```

---

## 🔧 调用脚本已创建

**文件位置**: `/Users/hokeli/call_sambert_api.py`

---

## 🎯 使用方式

### 基本调用

```bash
python3 ~/call_sambert_api.py --text "武松台词" --voice zhifeng
```

---

### 角色自动映射

```bash
python3 ~/call_sambert_api.py --text "武松打虎" --role 武松
# 自动映射武松 → zhifeng发音人
```

---

### 指定输出文件

```bash
python3 ~/call_sambert_api.py \
  --text "景阳冈上三碗不过冈" \
  --role 武松 \
  --output wusong_ep01.mp3
```

---

## 🎭 角色声音映射

| 角色 | 发音人 | 声音ID |
|------|--------|--------|
| **武松** | 知锋 | zhifeng |
| **林冲** | 知锋 | zhifeng |
| **宋江** | 知冰 | zhibing |
| **长老** | 知冰 | zhibing |
| **店小二** | 知米 | zhimi |
| **潘金莲** | 知妙 | zhimiao |
| **高俅** | 多尔切 | duolche |

---

## ⚠️ 当前状态

**SDK**: ✅ 已安装

**配置**: ✅ 已完成

**Token**: ⏳ **需要获取**

---

## 💡 立即操作

**获取Token后即可生成语音**:

```
控制台首页 → 点击 '获取临时AccessToken' → 复制Token → 再次运行脚本
```

---

*更新时间: 2026-04-13 23:48 PDT*
*SDK已安装，Token获取后可用*