---
id: e3325c_2026-08-15_090327
date: 2026-08-15
title: Physical AI 周报
type: 周报
---

数据收集完毕，生成周报。

## 🤖 Physical AI 周报 [Week of 2026-08-10 ~ 08-15]

### 🌟 TOP 开源项目
1. **Dalaran** — Apache-2.0 机器人优先的多模态时序数据可视化与基础设施，支持 ROS 2，上线一周即 963⭐ [github.com/Flaminis/Dalaran](https://github.com/Flaminis/Dalaran)
2. **τ0-VLA** — 分层机器人基础模型，引入 World-Model-Grounded 动作生成，440⭐ [github.com/sii-research/tau-0-vla](https://github.com/sii-research/tau-0-vla)
3. **MiniCPM-Robot** — OpenBMB 端侧机器人 AI 大脑，主打低延迟 on-device 推理，297⭐ [github.com/OpenBMB/MiniCPM-Robot](https://github.com/OpenBMB/MiniCPM-Robot)
4. **VisTouch** — 大规模同步视觉-触觉-音频滑动接触数据集，655⭐ [github.com/liangnjupt/VisTouch](https://github.com/liangnjupt/VisTouch)
5. **vla-evaluation-harness** — Allen AI 推出统一 VLA 评测框架，"一个框架评任意 VLA × 任意仿真基准"，534⭐ [github.com/allenai/vla-evaluation-harness](https://github.com/allenai/vla-evaluation-harness)

持续活跃：lerobot 26.7k⭐、genesis-world 29.7k⭐、IsaacLab 7.9k⭐、MuJoCo 14.6k⭐。

### 📄 TOP 论文
1. **G0.5: One Autoregressive Stream for Robot Reasoning and Action** — 打破"VLM 编码器 + flow-matching 动作专家"范式，单一自回归流统一推理与动作 [arXiv:2608.11739](https://arxiv.org/abs/2608.11739)
2. **Flex-π** — 多流 World-Action Model，显式建模 3D 几何与物体状态，算力可调 [arXiv:2608.10860](https://arxiv.org/abs/2608.10860)
3. **Temporal GRPO** — 突破轨迹级信用分配，为 VLA 强化学习后训练提供细粒度时序 credit [arXiv:2608.13026](https://arxiv.org/abs/2608.13026)
4. **DreamX-Phi 1.0** — 动作条件视频世界模型用于机器人操作，给定观测帧+指令+动作序列即可预测 [arXiv:2608.13489](https://arxiv.org/abs/2608.13489)
5. **Decoding Task Progress from VLA Representations** — 首批 VLA 可解释性工具：从内部表征解码任务进度 [arXiv:2608.13474](https://arxiv.org/abs/2608.13474)

### 🏢 行业动态
- **汽车工厂** — NYT 报道人形机器人即将进入车厂产线，移动操作+人形被 The Robot Report 评为行业未来 [link](https://www.therobotreport.com/mobile-manipulators-and-humanoids/)
- **A3** — Q2 2026 北美机器人需求全行业回升 [link](https://www.therobotreport.com/q2-2026-robotics-demand-increased-across-industries-reports-a3/)
- **融资** — Neros Technologies 防务无人机 $250M；Cambridge Aerospace $300M
- **Celona** — 发布 Orion agentic 无线平台，专为 Physical AI/机器人车队联网设计 [link](https://www.therobotreport.com/celona-launches-orion-agentic-wireless-platform-built-for-physical-ai-robotics/)
- **触觉** — IEEE 报道欧洲团队实现 100μm 分辨率触觉传感器；BioflexBot 仿生手复现人手关键运动

### 🔍 趋势分析
本周最显著信号是 **World-Action Model (WAM) 范式爆发**：Flex-π、DreamX-Phi、Surgical WAM、BrainWAM、LiLa-WAM 同期涌现，"预测未来以更好地行动"正取代纯行为克隆成为主流。其次是 **VLA 后训练精细化**（Temporal GRPO 解决轨迹级 credit 过粗问题）与**触觉模态升温**（数据集+传感器+综述三管齐下）。VLA 评测标准化（Allen AI harness）意味着领域进入"可比性"阶段。

### 💡 下周关注
- RoboBusiness 2026 人形机器人专题讨论（Figure/Agibot 等专家出席）
- τ0-VLA 与 G0.5 代码/权重是否放出，WAM 路线能否在真机 benchmark 上兑现
