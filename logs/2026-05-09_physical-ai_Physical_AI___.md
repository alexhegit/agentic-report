---
id: e3325c_2026-05-09
date: 2026-05-09
title: Physical AI 周报
type: 周报
---

Now I have comprehensive data. Let me compile the report.

## 🤖 Physical AI 周报 | 2026年5月第2周 (2026.05.04 - 2026.05.09)

### 🌟 TOP 开源项目 (本周最 hot 的 3-5 个)

1. **[Large-VLM-based-VLA-for-Robotic-Manipulation](https://github.com/JiuTian-VL/Large-VLM-based-VLA-for-Robotic-Manipulation)** - 大型 VLM 驱动的 VLA 机器人操作模型合集，覆盖当前主流 VLA 架构（⭐402）
2. **[OpenHelix](https://github.com/OpenHelix-Team/OpenHelix)** - 开源双系统 VLA 模型，面向机器人操作的全栈解决方案（⭐372）
3. **[mimic-video](https://github.com/mimic-video/mimic-video)** - 超越传统 VLA 的视频-动作模型，实现泛化机器人控制（⭐241）
4. **[vla-evaluation-harness](https://github.com/allenai/vla-evaluation-harness)** - AllenAI 发布：统一的 VLA 模型评估框架，支持任意模型跑任意仿真基准（⭐278，本周更新）
5. **[MemoryVLA](https://github.com/shihao1895/MemoryVLA)** - ICLR 2026 接收：为 VLA 引入感知-认知记忆机制（⭐235）

### 📄 TOP 论文 (本周最值得关注 5 篇)

1. **[OA-WAM: Object-Addressable World Action Model for Robust Robot Manipulation](https://arxiv.org/abs/2605.06481v1)** - 世界动作模型首次实现"物体可寻址"，解决 VLA 中目标指代的难题，是 VLA 演进的重要突破 [arXiv]
2. **[ReActor: Reinforcement Learning for Physics-Aware Motion Retargeting](https://arxiv.org/abs/2605.06593v1)** - SIGGRAPH 2026 接收！用 RL 做物理感知运动重映射，打通人-to-机器人（含四肢动物）的姿势迁移 [arXiv]
3. **[Reconstruction or Semantics? What Makes a Latent Space Useful for Robotic World Models](https://arxiv.org/abs/2605.06388v1)** - 探讨世界模型潜空间设计的核心问题——重建 vs 语义，为 VLA 仿真训练提供底层指导 [arXiv]
4. **[When to Trust Imagination: Adaptive Action Execution for World Action Models](https://arxiv.org/abs/2605.06222v1)** - 世界模型"何时该信"的问题：自适应停止机制让机器人动态决定置信度，打破固定步长范式 [arXiv]
5. **[RobotEQ: Transitioning from Passive Intelligence to Active Intelligence in Embodied AI](https://arxiv.org/abs/2605.06234v1)** - 提出具身 AI 从"被动执行"到"主动理解"的范式转变，机器人需理解"不应该做什么" [arXiv]

### 🏢 行业动态 (本周大事)

- **VLA 技术范式加速收敛** — 本周 arXiv 涌现大量 "World Action Models" 相关论文（OA-WAM、CKT-WAM、自适应执行等），表明 WAM 已成为 VLA 的主流演进方向，世界模型从"预测画面"走向"可操作化理解"
- **视频-动作模型崛起** — mimic-video 等项目展示用视频替代传统动作 token 作为策略中间表示的可行性，可能挑战 Diffusion Policy 的主导地位
- **仿真评估标准化** — AllenAI 发布 vla-evaluation-harness，VLA 基准评测进入统一时代，此前各论文各跑各榜的混乱局面有望结束
- **运动迁移物理一致性突破** — ReActor (SIGGRAPH 2026) 解决关键痛点：不同形态机器人间的运动映射，对 humanoid/四足等跨形态仿真→实机至关重要

### 🔍 趋势分析

本周最显著的趋势是 **World Action Models (WAM) 生态爆发**。OA-WAM 将世界模型输出从"全局图像/token"细化到"物体级可操作表示"，CKT-WAM 解决跨模型知识迁移，自适应执行论文则解决推理时的信赖问题——三者合围，构成了 WAM 的完整技术栈。与此同时，**VLA 评估工具链正在完善**，从 benchmark(harness) 到代码库(Awesome-RL-VLA 已 682 star)再到开源实现(mimic-video)，整个生态趋于成熟。**另一值得注意的动向是"超越 VLA"的探索**：纯视频动作模型可能提供更强的泛化能力，是 Droid/ACT/Diffusion Policy 之外的新路径。

### 💡 下周关注

1. **SIGGRAPH 2026 后续影响** — ReActor 等 motion retargeting 论文在 SIGGRAPH 的发表将推动 humanoid 机器人运动生成领域，关注后续开源实现
2. **VLA-2 系列更新** — 关注 OpenVLA、RT-X、Figure AI 是否有 v2 版本或新数据集发布，本周 arXiv 尚未出现重大更新，下周可能出消息

---
*数据来源：arXiv cs.RO/cs.AI/eess.SY API、GitHub Search API | 生成时间 2026-05-09*
