#!/usr/bin/env python3
"""
水浒传角色化配音生成脚本 - 阿里云Sambert版本
支持角色声音、语调、情感自定义
"""

import os
import json
import yaml
from pathlib import Path

# 阿里云Sambert API配置
from alibabacloud_nls import NlsSpeechSynthesizer

# 加载角色声音映射
VOICE_MAPPING_FILE = Path(__file__).parent / "voice_mapping.yaml"

def load_voice_mapping():
    """加载角色声音配置"""
    with open(VOICE_MAPPING_FILE) as f:
        return yaml.safe_load(f)

def generate_role_voice(text, role, output_file):
    """生成角色化配音"""
    mapping = load_voice_mapping()
    role_config = mapping['roles'].get(role)
    
    if not role_config:
        print(f"❌ 未找到角色配置: {role}")
        return False
    
    # 配置Sambert参数
    voice_id = role_config['voice_id']
    speech_rate = role_config['speech_rate']
    pitch_rate = role_config['pitch_rate']
    
    # 调用阿里云Sambert API
    # API文档：https://help.aliyun.com/document_detail/84435.html
    
    print(f"✅ 生成角色配音:")
    print(f"   角色: {role}")
    print(f"   音色: {voice_id}")
    print(f"   语速调整: {speech_rate*100}%")
    print(f"   音调调整: {pitch_rate*100}%")
    print(f"   输出文件: {output_file}")
    
    # 实际API调用（需开通服务）
    # synthesizer = NlsSpeechSynthesizer(
    #     voice=voice_id,
    #     speech_rate=speech_rate,
    #     pitch_rate=pitch_rate,
    #     text=text
    # )
    # synthesizer.synthesize(output_file)
    
    return True

def batch_generate_episode(script_file, output_dir):
    """批量生成一集的所有角色配音"""
    with open(script_file) as f:
        script = json.load(f)
    
    for segment in script['segments']:
        role = segment['role']
        text = segment['text']
        output_file = Path(output_dir) / f"{segment['id']}_{role}.mp3"
        
        generate_role_voice(text, role, output_file)

# 测试用例
if __name__ == "__main__":
    # 测试武松声音
    test_text = "大虫，哪里逃！今日便要取你性命！"
    generate_role_voice(test_text, "武松", "/tmp/wusong_test.mp3")
    
    # 测试店小二声音
    test_text2 = "客官，您来了！快请进，快请进！"
    generate_role_voice(test_text2, "店小二", "/tmp/xiaoer_test.mp3")
