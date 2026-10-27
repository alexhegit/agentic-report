---
id: 17abfd_2026-10-14_090241
date: 2026-10-14
title: Physical AI 日报
type: 日报
---

## 🤖 Physical AI 日报 [2026-10-14]

### 🔥 热门开源项目
- **[rzc156/dreamforge]** - 单 GPU 可跑的世界模型「想象」→ 纠错训练数据流水线（SmolVLA + LIBERO + CEM 配对仿真回放） [github.com/rzc156/dreamforge](https://github.com/rzc156/dreamforge)
- **[BinceQu/RoboHarness]** - 给 LLM agent 一个视觉-几何控制面板，直接理解并调用具身任务（本周 241⭐） [github.com/BinceQu/RoboHarness](https://github.com/BinceQu/RoboHarness)
- **[seohongpark/ocbench]** - 机器人操作的可控性评测基准 [github.com/seohongpark/ocbench](https://github.com/seohongpark/ocbench)
- **[fayazara/robot-heads]** - React 动画 3D 机器人头像，实时可视化 agent 状态（一周 321⭐） [github.com/fayazara/robot-heads](https://github.com/fayazara/robot-heads)

### 📄 重要论文 / 预印本
- **[GreenWAM: A World Foundation Model for Robotics]** - 统一世界模型+动作策略基础模型：共享解剖动作空间覆盖 20 类本体，WorldArena/RoboTwin 双榜 SOTA，可适配真机人形 [arxiv.org/abs/2610.18774](https://arxiv.org/abs/2610.18774)
- **[WAVE-0: Bridging VLA Policies and WAMs]** - 257M 轻量隐空间世界模型桥接 VLA 与 WAM，把 π₀.₅ 真机成功率从 38.3% 提到 73.3% [arxiv.org/abs/2610.18568](https://arxiv.org/abs/2610.18568)
- **[ACCRUE: Continual Off-Policy RL for Robot Foundation Models]** - 跨任务继承 actor/critic，近零遗忘，真机训练时间缩短 31%~68.5% [arxiv.org/abs/2610.18596](https://arxiv.org/abs/2610.18596)
- **[LIBERO-RIG]** - 只扰动硬件配置（相机位姿、标定、控制频率等 11 轴）的 VLA 鲁棒性基准，9 个 SOTA 模型重度扰动下成功率腰斩 [arxiv.org/abs/2610.18843](https://arxiv.org/abs/2610.18843)
- **[ChunkAct: Action Chunking for Agentic Robotics]** - 动作分块使 LLM 计算量随决策数而非原语数增长，LIBERO-Pro +5.0 点、LLM 调用少 2.9x [arxiv.org/abs/2610.18874](https://arxiv.org/abs/2610.18874)

### 🏢 行业动态
- **AWS** - 发布开源 Physical AI Toolchain，集成 AWS 服务 + NVIDIA 物理 AI 栈（合成数据、训练、仿真、边缘部署）
- **Boston Dynamics** - 公布重新设计的人形机器人手部细节
- **Helm.ai** - 其基础模型商用合同额达 7000 万美元

### 💡 值得关注
- 今天 arXiv 几乎被世界模型刷屏（GreenWAM、WAVE-0、UniW(A)M、WorldOracle）：**WAM「世界-动作模型」已成为与 VLA 并列的独立赛道**；同时 LIBERO-RIG 提示行业开始拷问 VLA 在硬件漂移下的真机健壮性，仿真刷榜的边际价值在下降。
