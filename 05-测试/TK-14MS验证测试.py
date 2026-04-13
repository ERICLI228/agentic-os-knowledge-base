#!/usr/bin/env python3
"""
TK-20260413-001 全面测试验证
验证14里程碑完整性、决策点、产出物结构
"""

import json
from pathlib import Path
import sys

TASK_FILE = Path.home() / ".openclaw/workspace/tasks/active/TK-20260413-001.json"

class TKTaskValidator:
    def __init__(self, task_file):
        self.task_file = task_file
        self.task = None
        self.errors = []
        self.warnings = []
        self.passed = []
        
    def load_task(self):
        """加载任务JSON"""
        try:
            with open(self.task_file) as f:
                self.task = json.load(f)
            self.passed.append("JSON格式正确")
            return True
        except Exception as e:
            self.errors.append(f"JSON加载失败: {e}")
            return False
    
    def validate_structure(self):
        """验证基础结构"""
        required_fields = ["id", "title", "status", "milestones", "decision_points"]
        for field in required_fields:
            if field not in self.task:
                self.errors.append(f"缺少必要字段: {field}")
            else:
                self.passed.append(f"字段存在: {field}")
    
    def validate_milestones_count(self):
        """验证里程碑数量"""
        count = len(self.task.get("milestones", []))
        if count != 14:
            self.errors.append(f"里程碑数量错误: {count} (应为14)")
        else:
            self.passed.append(f"里程碑数量正确: {count}")
    
    def validate_milestone_details(self):
        """验证每个里程碑的详细信息"""
        required_ms_fields = [
            "id", "name", "module", "decision_type", "priority",
            "status", "execution_details"
        ]
        
        for ms in self.task.get("milestones", []):
            ms_id = ms.get("id", "UNKNOWN")
            
            # 检查必要字段
            for field in required_ms_fields:
                if field not in ms:
                    self.errors.append(f"{ms_id}: 缺少字段 {field}")
                else:
                    self.passed.append(f"{ms_id}: {field} 存在")
            
            # 检查execution_details结构
            ed = ms.get("execution_details", {})
            if "output_content" not in ed:
                self.errors.append(f"{ms_id}: 缺少output_content")
            elif "data" not in ed.get("output_content", {}):
                self.warnings.append(f"{ms_id}: output_content.data 为空")
            else:
                self.passed.append(f"{ms_id}: output_content完整")
            
            # 检查决策点标记
            if ms.get("decision_required") and not ms.get("decision_point"):
                self.errors.append(f"{ms_id}: decision_required=True但decision_point=False")
            
            # 检查状态
            if ms.get("status") not in ["pending", "running", "completed", "failed"]:
                self.warnings.append(f"{ms_id}: 状态值异常 {ms.get('status')}")
    
    def validate_decision_points(self):
        """验证决策点"""
        dp_count = len(self.task.get("decision_points", []))
        if dp_count != 3:
            self.errors.append(f"决策点数量错误: {dp_count} (应为3)")
        else:
            self.passed.append(f"决策点数量正确: {dp_count}")
        
        required_dp_fields = ["id", "milestone_id", "status"]
        for dp in self.task.get("decision_points", []):
            dp_id = dp.get("id", "UNKNOWN")
            for field in required_dp_fields:
                if field not in dp:
                    self.errors.append(f"{dp_id}: 缺少字段 {field}")
    
    def validate_p0_milestones(self):
        """验证P0里程碑"""
        p0_ms = ["MS-1", "MS-2", "MS-3", "MS-7", "MS-10", "MS-11", "MS-12", "MS-14"]
        for ms in self.task.get("milestones", []):
            if ms.get("priority") == "P0":
                if ms.get("id") not in p0_ms:
                    self.warnings.append(f"{ms.get('id')}: P0标记但不在P0列表")
        
        found_p0 = [ms["id"] for ms in self.task.get("milestones", []) if ms.get("priority") == "P0"]
        if len(found_p0) == len(p0_ms):
            self.passed.append(f"P0里程碑完整: {len(found_p0)}个")
        else:
            self.errors.append(f"P0里程碑缺失: 应有{len(p0_ms)}个, 实际{len(found_p0)}个")
    
    def validate_charts_structure(self):
        """验证图表结构"""
        chart_types_valid = ["pie", "bar", "line", "radar", "doughnut", "funnel", "bar_horizontal", "word_cloud", "table"]
        
        for ms in self.task.get("milestones", []):
            charts = ms.get("execution_details", {}).get("charts", [])
            for chart in charts:
                if "id" not in chart:
                    self.warnings.append(f"{ms['id']}: 图表缺少id")
                if "type" not in chart:
                    self.errors.append(f"{ms['id']}: 图表缺少type")
                elif chart["type"] not in chart_types_valid:
                    self.warnings.append(f"{ms['id']}: 图表类型异常 {chart['type']}")
                if "title" not in chart:
                    self.warnings.append(f"{ms['id']}: 图表缺少title")
    
    def validate_artifacts_structure(self):
        """验证产物结构"""
        artifact_types_valid = ["image", "video", "audio", "text", "excel", "pdf", "zip"]
        
        for ms in self.task.get("milestones", []):
            artifacts = ms.get("execution_details", {}).get("artifacts", [])
            for artifact in artifacts:
                if "name" not in artifact:
                    self.errors.append(f"{ms['id']}: 产物缺少name")
                if "type" not in artifact:
                    self.warnings.append(f"{ms['id']}: 产物缺少type")
                elif artifact["type"] not in artifact_types_valid:
                    self.warnings.append(f"{ms['id']}: 产物类型异常 {artifact['type']}")
    
    def validate_decision_types(self):
        """验证决策类型"""
        valid_types = ["AI自动", "AI预警+用户决策", "强制人工", "AI建议+用户确认"]
        
        for ms in self.task.get("milestones", []):
            dt = ms.get("decision_type")
            if dt not in valid_types:
                self.warnings.append(f"{ms['id']}: decision_type异常 '{dt}'")
    
    def validate_modules(self):
        """验证模块分布"""
        modules = {}
        for ms in self.task.get("milestones", []):
            module = ms.get("module", "UNKNOWN")
            modules[module] = modules.get(module, 0) + 1
        
        expected_modules = ["选品洞察", "内容工业化", "多账号发布", "广告智能化", "订单履约", "客服自动化", "数据归因"]
        for module in expected_modules:
            if module not in modules:
                self.warnings.append(f"模块缺失: {module}")
        
        self.passed.append(f"模块分布: {len(modules)}个模块")
    
    def validate_status_consistency(self):
        """验证状态一致性"""
        if self.task.get("status") != "completed":
            self.warnings.append(f"任务状态为 {self.task.get('status')}, 但所有里程碑已完成")
        
        completed_ms = [ms for ms in self.task.get("milestones", []) if ms.get("status") == "completed"]
        if len(completed_ms) == 14:
            self.passed.append("里程碑全部完成")
        else:
            self.warnings.append(f"里程碑完成数: {len(completed_ms)}/14")
    
    def run_all_tests(self):
        """执行所有测试"""
        if not self.load_task():
            return False
        
        self.validate_structure()
        self.validate_milestones_count()
        self.validate_milestone_details()
        self.validate_decision_points()
        self.validate_p0_milestones()
        self.validate_charts_structure()
        self.validate_artifacts_structure()
        self.validate_decision_types()
        self.validate_modules()
        self.validate_status_consistency()
        
        return True
    
    def report(self):
        """输出测试报告"""
        print("=" * 60)
        print("📋 TK-20260413-001 全面测试验证报告")
        print("=" * 60)
        
        print(f"\n✅ 通过测试: {len(self.passed)}")
        for item in self.passed:
            print(f"  ✅ {item}")
        
        print(f"\n⚠️ 警告: {len(self.warnings)}")
        for item in self.warnings:
            print(f"  ⚠️ {item}")
        
        print(f"\n❌ 错误: {len(self.errors)}")
        for item in self.errors:
            print(f"  ❌ {item}")
        
        print("=" * 60)
        
        if len(self.errors) > 0:
            print("❌ 测试失败: 存在严重错误")
            return 1
        elif len(self.warnings) > 0:
            print("⚠️ 测试通过但有警告")
            return 0
        else:
            print("✅ 全部测试通过")
            return 0

if __name__ == "__main__":
    validator = TKTaskValidator(TASK_FILE)
    validator.run_all_tests()
    exit_code = validator.report()
    sys.exit(exit_code)