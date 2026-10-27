---
id: e3325c_2026-08-01
date: 2026-07-27
title: Physical AI 周报
type: 周报
---

## 🤖 Physical AI 周报 [Week of 2026-07-27 ~ 08-01]

### 🌟 TOP 开源项目
1. **Robbyant/lingbot-video** - 面向具身智能的 MoE 视频预训练，本月新仓库即获近 900 星，配套 lingbot-vla-v2-6B 模型已上 HF (⭐895) [github](https://github.com/Robbyant/lingbot-video)
2. **sii-research/tau-0-vla** - τ0-VLA：带世界模型的分层机器人基础模型，开源一周热度飙升 (⭐245) [github](https://github.com/sii-research/tau-0-vla)
3. **GalaxyGeneralRobotics/Humanoid-GPT** - CVPR 2026 工作，数据+结构规模化实现零样本人形动作跟踪 (⭐403) [github](https://github.com/GalaxyGeneralRobotics/Humanoid-GPT)
4. **superxslam/SuperMap** - 具身 AI 的"活体空间记忆"，感知并记忆环境演化 (⭐204) [github](https://github.com/superxslam/SuperMap)
5. **Roboparty/UFO** - 人形控制无监督 RL 框架（FB/TeCH 训练）(⭐152) [github](https://github.com/Roboparty/UFO)；另：**ScaleBFM**（人形行为基础模型规模化）⭐159 [github](https://github.com/zengweishuai/ScaleBFM)

### 📄 TOP 论文
1. **TurboVLA** - RTX 4090 上 <1GB 显存实现 32Hz 实时 VLA，端侧部署里程碑 [arxiv](http://arxiv.org/abs/2607.27205v1)
2. **RedFlow** - 将失败重定向为动作级修正，提升 flow-matching VLA 鲁棒性 [arxiv](http://arxiv.org/abs/2607.27782v1)
3. **RL²-VLA** - RL 潜空间组合引导 + 测试时扩展的 VLA 新范式 [arxiv](http://arxiv.org/abs/2607.26991v2)
4. **CheckVLA** - 用动作条件世界模型做长程移动操作的执行时验证 [arxiv](http://arxiv.org/abs/2607.26789v1)
5. **World Action Planner** - 动作条件世界模型实现可泛化决策 [arxiv](http://arxiv.org/abs/2607.27599v1)

### 🏢 行业动态
- **FCC** - 出台新规限制美国人形/移动机器人新品进口，行业强烈反应（本周最大政策事件）[link](https://www.therobotreport.com/industry-reacts-fcc-ban-u-s-imports-new-humanoid-quadruped-robots/)
- **Procore** - 8.45 亿美元收购 DroneDeploy [link](https://www.therobotreport.com/procore-technologies-acquires-dronedeploy-845m/)
- **Teradyne Robotics** - Q2 收入同比 +33%，协作机器人回暖 [link](https://www.therobotreport.com/teradyne-robotics-revenue-rises-33-year-over-year-in-q2/)
- **DoorDash** - 获 FAA 认证可自营无人机配送 [link](https://www.therobotreport.com/doordash-gains-faa-certification-to-operate-its-own-drone-delivery-program/)
- **HF 动态** - Unitree UnifoLM-VLA-Base、InternRobotics VLAC、Microsoft VITRA-VLA-3B 进入 VLA 趋势榜

### 🔍 趋势分析
VLA 正从"能跑"走向"实时+轻量"（TurboVLA 把门槛压到消费级显卡），同时世界模型成为 VLA 的"验证器/纠错器"（CheckVLA、RedFlow、WAP 同周涌现），policy+world model 耦合架构渐成主流。政策面上 FCC 收紧进口 vs 中国人形开源生态（Humanoid-GPT、UFO、lingbot）加速，地缘分化值得警惕。

### 💡 下周关注
- FCC 新规细则落地及 Unitree/智元等厂商应对
- RoboBusiness 2026 已开放注册（10 月）[link](https://www.therobotreport.com/registration-is-open-for-robobusiness-2026/)
