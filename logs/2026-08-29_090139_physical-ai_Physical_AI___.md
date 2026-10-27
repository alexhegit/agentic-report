---
id: e3325c_2026-08-29_090139
date: 2026-08-29
title: Physical AI 周报
type: 周报
---

## 🤖 Physical AI 周报 [Week of 2026-08-23 ~ 08-29]

### 🌟 TOP 开源项目
1. **Genesis (genesis-world)** — 通用机器人/具身智能仿真平台，本周持续活跃 [⭐29.8k] [github.com/Genesis-Embodied-AI/genesis-world]
2. **huggingface/lerobot** — 端到端机器人学习框架，HF 生态核心 [⭐27.0k] [github.com/huggingface/lerobot]
3. **Physical-Intelligence/openpi** — π0 系列 VLA 开源实现，π0.5 成多家 baseline [⭐13.5k] [github.com/Physical-Intelligence/openpi]
4. **isaac-sim/IsaacLab** — NVIDIA 统一机器人学习框架 [⭐8.0k] [github.com/isaac-sim/IsaacLab]
5. **MA-VLA (future-robots)** — 多臂协作 VLA，代码+模型+数据全开放 (ECCV 2026) [github.com/zhangzaibin/future-robots]

### 📄 TOP 论文
1. **LM-X** — 可解释 VLA：RTG/ETG/不确定性三路显式监督，2 万小时真机数据训练，RoboTwin2.0 50 任务 74.1% vs GR00T N1.7 的 55.4% [arxiv.org/abs/2608.25757]
2. **FlashVLA** — 流式动作解码，flow-matching VLA 单卡实现 ≥30Hz 控制频率、平滑异步推理 [arxiv.org/abs/2608.27384]
3. **UCAG-P** — 相机中心统一动作几何空间，单 checkpoint 跨机械臂/人形/人手：LIBERO 98.3%、RoboTwin 88.7% [arxiv.org/abs/2608.26058]
4. **CLAP** — 跨形态视频世界模型可零样本充当物理仿真器 [arxiv.org/abs/2608.27406]
5. **NVIDIA Cosmos-H-Dreams** — 首个可实时交互的手术世界模型，单卡 ~160 FPS 流式推理并开放系统 [arxiv.org/abs/2608.24199]

### 🏢 行业动态
- **小鹏** — 人形机器人子公司 Dogotix 融资 9 亿美元，本周最大单笔
- **Gatik** — 自动驾驶卡车获 2 亿美元融资继续扩张
- **EXL** — 收购 physical-AI 模型开发商 iMerit（后者同周与 Carbon Robotics 合作田间 AI）
- **NSF** — 投资 9000 万美元建三个技术中心，含机器人方向
- **NVIDIA** — Jetson Orin Nano 2 发布，边缘机器人推理性能翻倍
- **Teradyne Robotics** — 升级对协作机器人山寨厂商的法律攻势

### 🔍 趋势分析
本周 VLA 研究呈现明显"三线并进"：**效率线**（FlashVLA/StreamPI 流式异步推理逼近实时部署）、**解释性线**（LM-X 用显式多时间尺度状态替代黑盒动作头）、**统一性线**（UCAG-P/MA-VLA 跨形态、跨臂构泛化）。世界模型则从"生成好看视频"转向"可交互仿真器"——CLAP 零样本物理仿真与 Cosmos-H-Dreams 实时手术模拟都指向 world-model-as-simulator 的落地路径。产业端资本持续涌入（小鹏 9 亿美元为标志），人形赛道与自动驾驶卡车并行吸金。

### 💡 下周关注
- LM-X 若开源权重/代码，可能刷新通用 VLA 基准；关注其官方发布
- RoboBusiness 2026（早鸟票 8/31 截止）前后的厂商新品公告窗口
