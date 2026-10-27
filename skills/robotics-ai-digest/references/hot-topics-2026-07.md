# Hot Repos & Papers — July 2026

## 📄 Key Papers (arXiv cs.RO, 2026-07-07 — NEW TODAY)

| ID | Title | Key Insight |
|----|-------|-------------|
| 2607.05396 | From Fixed to Free Cameras: Calibration-Free View-Robust VLA | VLA相机位置变动无需重校准，训练时解耦extrinsic，真机部署鲁棒性大幅提升 |
| 2607.05377 | Cortex: Bidirectionally Aligned Embodied Agent for Long-horizon Manipulation | 双向对齐框架解决Makov依赖，突破长时序任务瓶颈 |
| 2607.05390 | Deform360: Multi-view Visuotactile Dataset for Deformable World Models | 大规模多视角触觉数据集，覆盖软体变形动力学 |
| 2607.04927 | DSWAM: Dual-System World Action Foundation Model | WAM双系统架构：视频世界建模dense监督+机器人动作学习 |
| 2607.04940 | Closing the Reality Gap: Dexterous Hand Zero-Shot Sim2Real | 无域随机化零样本灵巧手迁移，突破接触丰富任务 |
| 2607.04988 | InternVLA-A1.5: Unified Understanding + Latent Foresight + Action | 统一理解+潜预测+动作，组合泛化SOTA |

## 🚀 Trending GitHub Repos (2026-07-07 update)

| Repo | Stars | Description |
|------|-------|-------------|
| Genesis-Embodied-AI/genesis-world | 29.5k | 通用机器人+具身AI仿真平台 |
| HuggingFace/lerobot | 25.5k | HuggingFace端到端机器人学习框架 |
| NVIDIA/Isaac-GR00T | 7.5k | Isaac GR00T N1.7 通用机器人基础模型 |
| isaac-sim/IsaacLab | 7.6k | NVIDIA Isaac Sim统一机器人学习框架 |
| YanjieZe/GMR | 2.4k | 通用运动重定向：人体→各类人形机器人实时迁移 (ICRA 2026) |
| unitreerobotics/xr_teleoperate | 1.5k | Unitree人形机器人XR遥操作 |
| roboterax/humanoid-gym | 2k | 人形机器人强化学习零样本sim2real |
| NVlabs/ProtoMotions | 1.9k | GPU加速人形数字人仿真+学习框架 |

## 📄 Key Papers (arXiv cs.RO, 2026-07-02 ~ 2026-07-06)

| ID | Title | Key Insight |
|----|-------|-------------|
| 2607.02466 | TAP: Task-Agnostic Pretraining for VLAs | 两阶段VLA预训练：先学运动先验（无标注交互数据）再对齐语言，SIMPLER SOTA，ICML 2026 |
| 2607.02431 | WorldSample: Closed-loop Real-robot RL with World Modelling | 世界模型数据增强+策略节奏学习，成功率+28%，训练步数-59% |
| 2607.02332 | HEFT: Heavy-Payload Full-size Humanoid Teleoperation | 全尺寸人形24kg负重遥操作， Privileged Motion Guidance + Payload Curriculum |
| 2607.02503 | VT-WAM: Visual-Tactile World Action Model | 视触觉融合World Action Model，flow matching统一框架，6任务71.67% |
| 2607.02322 | The Moving Eye: Enhancing VLA Spatial Generalization | 双臂混合视角数据消除捷径学习，所有架构(ACT/Diffusion/Gr00t)均受益 |
| 2607.02205 | Actuator Reality Shaping | 执行器闭环特性塑造实现零样本sim2real，无需任务级微调 |
| 2606.32009 | Human-as-Humanoid | 人类第一人称视频→人形机器人可执行动作，演示吞吐量4.8-7.2x提升 |
| 2607.01574 | Multi-Rate NMPC for Wall-Supported Bipedal Locomotion | 四足机器人壁面辅助双足运动，Unitree A1验证，成功率2.9x提升 |

## 💡 Emerging Patterns (2026 H1→H2)

1. **VLA物理表征学习新范式**: TAP等论文揭示——VLA瓶颈在于混淆"运动能力"和"语义对齐"，解耦后用无标注交互数据预训练运动先验可大幅提升鲁棒性和泛化
2. **Shortcut Learning是VLA泛化失败根因**: 混合连续运动+多样静态视角数据策略对所有VLA架构有效
3. **执行器级sim2real**: 不改仿真改执行器——Actuator Reality Shaping提供标准化接口实现零样本迁移
4. **视触觉融合操作**: VT-WAM等论文显示触觉变形动力学建模对接触丰富任务至关重要
5. **人形机器人遥操作规模化**: HEFT等框架通过VR+特权运动引导实现全尺寸人形24kg负重

## 🔑 Verified arXiv Query Patterns

```bash
# VLA + robot learning (confirmed working 2026-07-06)
curl -s "https://export.arxiv.org/api/query?search_query=cat:cs.RO+AND+all:robot+AND+all:learning&sortBy=submittedDate&sortOrder=descending&max_results=8"

# Humanoid robots
curl -s "https://export.arxiv.org/api/query?search_query=cat:cs.RO+AND+all:humanoid&sortBy=submittedDate&sortOrder=descending&max_results=5"

# Diffusion/imitation/manipulation
curl -s "https://export.arxiv.org/api/query?search_query=cat:cs.RO+AND+all:diffusion+OR+all:imitation+OR+all:manipulation&sortBy=submittedDate&sortOrder=descending&max_results=5"

# GitHub search (saves to file, then grep)
curl -s "https://api.github.com/search/repositories?q=humanoid+robot+language:python&sort=stars&order=desc&per_page=6" -o /tmp/gh_humanoid.json
grep -E '"full_name"|"description"|"stargazers_count"' /tmp/gh_humanoid.json
```