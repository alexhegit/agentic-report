---
id: 17abfd_2026-10-19
date: 2026-10-19
title: Physical AI 日报
type: 日报
---

## 🤖 Physical AI 日报 [2026-10-19]

### 🔥 热门开源项目
- **Gen-Verse/RSI-Anything** - 用世界模型解锁递归自我改进（RSI），近两周新仓中 star 增速最快 [⭐791](https://github.com/Gen-Verse/RSI-Anything)
- **kyutai-labs/reki (REKI)** - Kyutai 开源 2.4B VLA，仅用公开数据预训练，带"记忆 register"机制，LIBERO-Plus/RoboTwin 上打平 2 倍规模模型，[代码全开源](https://github.com/kyutai-labs/reki)
- **OpenDriveLab/EgoHumanoid-V2** - 人类到 humanoid 的全身协调技能迁移（locomanipulation），OpenDriveLab 新作 [⭐74](https://github.com/OpenDriveLab/EgoHumanoid-V2)
- **DexForce/UNITAS** - 3D 原生的 World-Action Model 操作框架，附官方代码 [⭐80](https://github.com/DexForce/UNITAS)

### 📄 重要论文 / 预印本
- **LAW: Unifying Language, Action, and World Modeling** - 语言、动作、世界建模三位一体的 Agentic 物理智能框架 [arXiv](https://arxiv.org/abs/2610.23334)
- **BeJEPA** - 基于无监督 RL 的目标条件 humanoid 行为世界模型（JEPA 路线） [arXiv](https://arxiv.org/abs/2610.23127)
- **MambaAct** - 用 Mamba action expert 加速 flow-matching VLA，推理效率新方案 [arXiv](https://arxiv.org/abs/2610.22951)
- **VeriVLA** - 免训练的测试时验证器：JEPA latent 世界模型给 flow-based VLA 的动作块打分排序，真实任务完成分 50.8%→65.5% [arXiv](https://arxiv.org/abs/2610.21985)

### 🏢 行业动态
- **Agility Robotics** - 选定 Nyobolt 固态电池为 Digit 5 人形机器人供电 + 超快充电方案
- **Stryker** - 向手术机器人公司 CMR Surgical 投资 4 亿美元
- **ADI** - 发布"AI 走向物理世界"白皮书，布局机器人模拟芯片基建

### 💡 值得关注
- **VLA 效率化成主线**：MambaAct（Mamba 替换 attention action head）、FastVLA（token 压缩）、REKI（小模型+记忆）同日密集出现——行业共识正从"堆大模型"转向"2-3B 小 VLA + 架构优化 + 记忆机制"。
- **世界模型从"看"到"评"**：LAW、VeriVLA、BeJEPA 都让世界模型承担动作验证/规划的角色，而不仅是生成视觉。
