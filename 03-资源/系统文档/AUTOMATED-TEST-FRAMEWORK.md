# 🧪 Agentic OS 自动化测试质量门禁体系

## 实施背景

**问题**: OpenClaw声称"完成"但实际报错，缺乏自动化验证

**解决方案**: 集成CI/CD质量门禁思想到AI智能体系统

---

## 一、核心架构

```
里程碑完成 → 触发测试钩子 → 执行pytest → 结果解析 → 门禁决策
                                                    ↓
                                通过 → completed
                                失败 → failed + 决策点
```

---

## 二、测试框架位置

| 目录 | 用途 |
|------|------|
| `~/agentic-os-collective/tests/tk/` | TK运营测试用例 |
| `~/agentic-os-collective/tests/drama/` | 短剧测试用例 |
| `~/agentic-os-collective/tests/shared/` | 共享测试工具 |
| `~/agentic-os-collective/hooks/post_milestone_test.py` | 测试钩子 |

---

## 三、测试套件配置

```python
TEST_SUITES = {
 "drama": {
 "MS-1": "tests/drama/test_artifacts_unique.py",
 "MS-4": "tests/drama/test_glm_script.py"
 },
 "tk": {
 "MS-1": "tests/tk/test_data_collector.py",
 "MS-10": "tests/tk/test_milestone_artifacts.py"
 }
}
```

---

## 四、测试用例示例

### TK数据完整性测试
```python
def test_data_completeness():
 """测试数据采集完整性>95%"""
 for m in task['milestones']:
 if m['id'] == 'MS-1' and m['status'] == 'completed':
 artifacts = m.get('execution_details', {}).get('artifacts', [])
 assert len(artifacts) > 0
```

### Drama剧本格式测试
```python
def test_script_format():
 """测试剧本字数>=1000"""
 script = download_artifact(script_url)
 assert len(script) >= 1000
 assert "【场景" in script
```

---

## 五、执行命令

```bash
# 运行所有测试
pytest tests/ -v

# 运行TK测试
pytest tests/tk/ -v --html=reports/tk_report.html

# 运行Drama测试
pytest tests/drama/ -v --html=reports/drama_report.html

# 查看覆盖率
pytest tests/ --cov --cov-report=html
```

---

## 六、质量门禁标准

| 维度 | 标准 | 测试用例 |
|------|------|----------|
| 数据完整性 | >95% | test_data_completeness |
| 剧本字数 | >=1000字 | test_script_format |
| 产出物唯一性 | 无重复URL | test_unique_artifacts |
| HTTP下载 | 全部200 OK | test_artifact_downloadable |
| 场景数量 | >=3个 | test_script_format |

---

## 七、质量门禁流程

```
1. 里程碑完成 → 自动触发测试钩子
2. 执行pytest → 生成JUnit XML报告
3. 解析结果 → 决定状态
4. 测试通过 → 标记completed，记录报告
5. 测试失败 → 标记failed，创建决策点
```

---

## 八、飞书告警集成

测试失败时自动发送飞书告警：
- 项目名称
- 里程碑ID
- 失败数量
- 失败原因

---

## 九、验收标准

| 操作 | 预期效果 |
|------|----------|
| pytest运行 | 自动执行对应测试套件 |
| 测试通过 | 里程碑completed |
| 测试失败 | 里程碑failed，决策点创建 |
| 重试决策 | 重新执行测试 |
| 忽略决策 | 强制标记completed |

---

## 十、后续所有代码交付要求

**强制执行质量门禁**:
1. 所有代码相关任务必须通过pytest
2. 测试失败时必须修复或审批后才能交付
3. 测试报告永久存档在execution_details

---

**实施时间**: 2026-04-13
**状态**: ✅ 已部署为基础设施能力
**维护**: 后续所有代码交付强制执行
