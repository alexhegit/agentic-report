# Hot Repos & Papers — June 2026

## 🚀 Trending GitHub Repos (stars as of 2026-06-30)

| Repo | Stars | Description |
|------|-------|-------------|
| commaai/openpilot | 62k+ | 自动驾驶操作系统，300+车型支持 |
| AtsushiSakai/PythonRobotics | 29k+ | Python机器人算法教材（路径规划、SLAM等）|
| Genesis-Embodied-AI/Genesis | 29k+ | 通用GPU仿真平台，机器人+Embodied AI |
| HuggingFace/lerobot | 25k+ | HuggingFace端到端机器人学习框架 |
| bullet3 | 14k+ | Bullet物理引擎（VR/机器人仿真）|
| iLearn-Lab/VLA-Diffusion-Policy-Robotics | 814 | 扩散模型+机器人操作综述库 |
| dyson-ai/hdp | 237 | CVPR 2024: 分层扩散策略多任务操作 |
| Skylark0924/Rofunc | 711 | 机器人示教学习与操作全流程Python包 |
| InternRobotics/OpenHomie | 581 | 人形机器人异构外骨骼操作台复现 |
| YanjieZe/Improved-3D-Diffusion-Policy | 543 | IROS 2025: iDP3 可泛化人形3D扩散策略 |
| LeCAR-Lab/FALCON | 393 | L4DC 2026: 力自适应人形机器人locomanip |
| NVlabs/GRAIL | 356 | 3D资产+视频先验合成人形locomanip数据 |

## 📄 Key Papers (arXiv cs.RO, 2026-06-29)

| ID | Title | Key Insight |
|----|-------|-------------|
| 2606.30645 | VLK: Learning Humanoid Loco-Manipulation from Synthetic Interactions | 3DGS重建场景+合成VLK数据→Unitree G1 sim2real |
| 2606.30552 | ZR-0: Training VLA with Dense Embodied Chain-of-Thought | 26亿参数VLA，ECoT+Diffusion Transformer，60M帧跨本体 |
| 2606.30632 | GROW²: Grounding Which and Where for Robot Tool Use | VLM层级化工具affordance，零样本开放类别物体 |
| 2606.30456 | Vision-Language-Action Models: Experimental Insights from UR5 | VLA部署到真实UR5：action语义/坐标/时序是真正瓶颈 |
| 2606.30457 | Behavior Prompting Policy (BPP) | 单次演示作为behavior prompt实现推理时新任务泛化 |
| 2606.30613 | Sequential Planning via Anchored Robotic Keypoints | 锚定机器人关键点的序列规划 |

## 💡 Emerging Patterns (2026 H2)

1. **VLA落地系统化**: 从"模型centric"转向"数据-模型-控制全流程" — action表示、坐标框架、时序对齐成为真正的部署瓶颈
2. **3DGS合成数据**: 3D Gaussian Splatting重建场景用于合成大规模robotics数据（VLK、GRAIL等）— 绕过了真实数据采集瓶颈
3. **人形机器人sim2real**: Unitree G1成为热门实验平台，多篇论文验证3D扩散策略、力适应控制等方法
4. **Diffusion Policy持续热**: 从单任务向多任务分层（hdp）、3D泛化（iDP3）方向发展
5. **工具使用**: GROW²等工作探索开放词汇工具选择和affordance grounding

## 🔑 Query Patterns for arXiv

```bash
# VLA / World Models
curl -s "https://export.arxiv.org/api/query?search_query=cat:cs.RO+AND+(VLA+OR+%22vision+language+action%22+OR+%22world+model%22)&max_results=5&sortBy=submittedDate&sortOrder=descending"

# Humanoid
curl -s "https://export.arxiv.org/api/query?search_query=cat:cs.RO+AND+humanoid&max_results=5&sortBy=submittedDate&sortOrder=descending"

# Diffusion Policy / RL
curl -s "https://export.arxiv.org/api/query?search_query=cat:cs.RO+AND+(diffusion+policy+OR+imitation+learning)&max_results=5&sortBy=submittedDate&sortOrder=descending"

# Sim2Real / Manipulation
curl -s "https://export.arxiv.org/api/query?search_query=cat:cs.RO+AND+(sim2real+OR+manipulation+OR+grasping)&max_results=5&sortBy=submittedDate&sortOrder=descending"
```