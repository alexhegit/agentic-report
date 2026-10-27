---
id: e3325c_2026-05-23_090405
date: 2026-05-23
title: Physical AI 周报
type: 周报
---

Now I have enough data to compile the report.

## 🤖 Physical AI 周报 (Week of May 19–23, 2026)

### 🌟 TOP 开源项目

1. **[iLearn-Lab/VLA-Diffusion-Policy-Robotics](https://github.com/iLearn-Lab/VLA-Diffusion-Policy-Robotics)** — VLA + Diffusion Policy 资源大全，涵盖最新扩散策略论文和实现，是研究扩散模型在机器人操作中应用的最佳入口 (⭐805)
2. **[zeroth-robotics/zeroth-bot](https://github.com/zeroth-robotics/zeroth-bot)** — 3D打印开源人形机器人平台，支持Sim2Real和RL训练，硬件成本极低，适合学术研究和快速原型验证 (⭐771)
3. **[NVlabs/GR00T-VisualSim2Real](https://github.com/NVlabs/GR00T-VisualSim2Real)** — NV Labs开源人形机器人视觉Sim2Real框架，训练在仿真中完成、零样本部署到真实机器人，是Sim2Real领域的重要进展 (⭐265)
4. **[droid-dataset/droid](https://github.com/droid-dataset/droid)** — 分布式机器人交互数据集(DROID)，覆盖多智能体协作场景，为多机器人强化学习和模仿学习提供高质量基准 (⭐362)
5. **[ManiCM-fast/ManiCM](https://github.com/ManiCM-fast/ManiCM)** — 基于Consistency Model的实时3D扩散策略，显著提升遥操作任务中的推理速度，为Diffusion Policy实时部署提供新思路 (⭐123)

### 📄 TOP 论文

1. **GesVLA: Gesture-Aware Vision-Language-Action Model Embedded Representations** (2605.22812) — 首次在VLA框架中引入手势感知能力，扩展了VLA模型的交互维度 [(arXiv)](https://arxiv.org/abs/2605.22812)
2. **Beyond Pixels: Learning Invariant Rewards for Real-World Robotics From a Few Demonstrations** (2605.22123) — 提出从少量示范中学习不变奖励函数，解决强化学习在开放世界操作中的reward设计难题 [(arXiv)](https://arxiv.org/abs/2605.22123)
3. **Beyond Euclidean Proximity: Repairing Latent World Models with Horizon-Matched Trajectory Reachability** (2605.22164) — 提出 horizon-matched 策略修复潜在世界模型在MPC中的终端代价评估偏差问题 [(arXiv)](https://arxiv.org/abs/2605.22164)
4. **roto 2.0: The Robot Tactile Olympiad** (2605.21429) — 触觉强化学习新版竞赛基准，推动触觉感知RL从单一方向任务向更复杂操作场景扩展 [(arXiv)](https://arxiv.org/abs/2605.21429)

### 🏢 行业动态

- **NVIDIA GR00T 开源Sim2Real** — NV Labs开源GR00T-VisualSim2Real框架，为人形机器人视觉 locomotion + manipulation 提供端到端仿真到部署方案
- **Zeroth Robotics humanoid 社区爆发** — zeroth-bot 771⭐证明3D打印人形机器人平台正成为低成本学术实验的新基础设施
- **DROID数据集持续扩展** — 分布式机器人交互数据集覆盖多智能体协作，为RL多机器人研究提供新基准

### 🔍 趋势分析

本周最显著的趋势是**扩散策略(Diffusion Policy)进入"实时化"(real-time)阶段**——ManiCM用Consistency Model加速推理、iLearn-Lab系统性整理扩散策略VLA资源，表明扩散策略已从"学术研究"迈入"工程落地"关键期。同时，**Sim2Real技术加速成熟**，GR00T-VisualSim2Real的开源标志着人形机器人从仿真到真实部署的链路正在被头部公司打通。**手势感知VLA(GesVLA)**的提出也值得关注——VLA模型正从纯"手-眼-语言"向多模态交互扩展，为更自然的机器人协作铺路。

### 💡 下周关注

1. **GR00T-VisualSim2Real的真实机器人部署结果**——NV Labs将在后续论文中公布Sim2Real零样本迁移的定量对比，验证其框架在人形机器人上的泛化能力
2. **VLA-Diffusion组合的开源实现**——随着iLearn-Lab资源整理的推进，预计近期将出现更多基于Diffusion Policy开源VLA模型的项目涌现，值得关注
