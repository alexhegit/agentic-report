---
id: e3325c_2026-05-16_091328
date: 2026-05-16
title: Physical AI 周报
type: 周报
---

Now I have enough arXiv data to compile the weekly digest. Let me analyze the most relevant robotics/AI papers and produce the report.

## 🤖 Physical AI 周报 (2026.05.12 - 2026.05.16)

### 🔥 TOP 开源项目 / 论文 (本周最值得关注)

**1. [Pelican-Unified 1.0](https://arxiv.org/abs/2605.15153)** - 首个"统一"形态基础模型，单个 VLM 统一完成感知、推理、想象力生成与动作输出，摆脱 VLA 管线割裂问题 (arXiv:2605.15153)

**2. [Hand-in-the-Loop](https://arxiv.org/abs/2605.15187)** - 灵巧操作 VLA 的人手介入修正框架，通过交互式模仿学习解决高维操作误差累积，适用于多指灵巧手长序列任务 (arXiv:2605.15157)

**3. [Evo-Depth](https://arxiv.org/abs/2605.14950)** - 轻量化深度增强 VLA，将 3D 深度信息注入 2D VLA 模型，显著提升空间理解与抓取精度，适合边缘部署 (arXiv:2605.14950)

**4. [IntentVLA](https://arxiv.org/abs/2605.14712)** - 针对"歧义操作"的短视 intents 建模 VLA，解决人类演示视频中同一场景多意图的问题 (arXiv:2605.14712)

**5. [DSSP 扩散状态空间策略](https://arxiv.org/abs/2605.14598)** - 全历史编码的扩散策略，突破现有 diffusion policy 仅依赖当前观测窗口的局限 (arXiv:2605.14598)

**6. [Chrono-Gymnasium](https://arxiv.org/abs/205.14911)** - 开源 Gymnasium 兼容分布式物理仿真框架，兼顾高保真物理引擎与 RL 训练效率 (arXiv:2605.14911)

**7. [SR-Platform](https://arxiv.org/abs/2605.14700)** - 自然语言驱动的仿真环境生成代理管线，从 text-to-MuJoCo 场景大幅降低仿真门槛 (arXiv:2605.14700)

### 🏢 行业动态

- **ByteDance UI-TARS** - 自动化 GUI 交互 native agent 周增 315⭐，持续领跑 agent 交互赛道 (GitHub: 10,590⭐)
- **Tesla Optimus** - 本周无重大更新，持续关注 FSD v13 对仿生机器人的迁移效应

### 🔍 趋势分析

本周 arXiv cs.RO 呈现一个清晰趋势：**VLA 正从"感知→决策"走向"统一感知-推理-行动"**。Pelican-Unified 1.0 提出的单模态统一范式是重要信号，Hand-in-the-Loop 和 IntentVLA 则指出 VLA 当前最大瓶颈——长序列误差累积和意图歧义。扩散策略（DSSP）和世界模型（Slot-MPC）路线也在加速合流。

### 💡 下周关注

- **NeurIPS 2025 Workshop 后续**：关注 UMoD 等机器人 benchmark 的开源进展
- **Tesla AI Day 2026**：可能公布 Optimus Gen 3 或 FSD-to-robot 路线图更新

---

*数据来源：arXiv cs.RO/AI 投稿 (2026-05-12~16)、GitHub trending、GitHub 搜索 API*
