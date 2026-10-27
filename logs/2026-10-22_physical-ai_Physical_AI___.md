---
id: 17abfd_2026-10-22
date: 2026-10-22
title: Physical AI 日报
type: 日报
---

## 🤖 Physical AI 日报 [2026-10-22]

### 🔥 热门开源项目
- **Foundation_of_Embodied_AI** - 新开的具身智能入门课程资料：机器人动力学、Isaac Lab、MuJoCo、ROS 2、GR00T，中英双语/tutorial 式讲解 [github.com/zengxiong111/Foundation_of_Embodied_AI](https://github.com/zengxiong111/Foundation_of_Embodied_AI)
- **every-embodied** - Datawhale 持续更新的教程：仅需 Python 基础，从 0 手写 OpenVLA/SmolVLA/π0 [github.com/datawhalechina/every-embodied](https://github.com/datawhalechina/every-embodied)
- **physical-hermes** - 把廉价 AI 机器狗玩具改造成 Hermes Agent 的语音实体，全程本地推理、无云依赖，开源硬件+Agent 结合的新玩法 [github.com/RegeneratusLabs/physical-hermes](https://github.com/RegeneratusLabs/physical-hermes)

### 📄 重要论文 / 预印本
- **SuperMimic** (CoRL 2026 Oral) - 用一个可微世界模型替代逐动作 RL，单 GPU 3 小时超越 128 GPU×7 天训练的运动追踪基线，已迁移到 Unitree G1 实机 [arxiv.org/abs/2610.28480](https://arxiv.org/abs/2610.28480)
- **Agentic World Action Models** - 当日的 WAM 新工作，把 agent 式推理接入世界-动作模型 [arxiv.org/abs/2610.30136](https://arxiv.org/abs/2610.30136)
- **AtomicRL** - 原子化强化学习分解长程操作子目标，提升长时程抓取成功率 [arxiv.org/abs/2610.30097](https://arxiv.org/abs/2610.30097)
- **TAPDreamer** - 对 World Action Model 的对抗贴片攻击：6.5% 像素扰动静态跨任务迁移，把 LIBERO 成功率打到 0%，WAM 安全性警报 [arxiv.org/abs/2610.06814](https://arxiv.org/abs/2610.06814)
- **AEON** (NeurIPS 2026) - 统一视频生成与 3D 生成两条世界模型路线，输出可渲染 4DGS 持久世界 [arxiv.org/abs/2610.28631](https://arxiv.org/abs/2610.28631)

### 🏢 行业动态
- **AGCO × Agility** - 在堪萨斯工厂部署 Digit 人形机器人，人形在大型制造业落地又一例（10-21）
- **Gecko Robotics** - 获美国海军 $300M 合同，军用四足/地面机器人需求回暖（10-20）
- **Kodama** - 融资 $7M 进军林业机器人；RoboBusiness 同期改名 "Robotics Summit & Expo West"（10-19/20）

### 💡 值得关注
- 本周 VLA 论文明显转向**鲁棒性与推理时效率**：RoboCasa-Shift/VLA-Retain 证明"目标域调参"会牺牲其他维度，FastVLA/VLA-Rolling/PACT-VLA 则把注意力放在 token 压缩与 action-chunk 复用——部署侧优化正在成为主线，而非新 backbone。

Sources: arXiv cs.RO 当日 API、luohongk/Embodied-AI-Daily（2026-10-20 批次）、The Robot Report RSS、GitHub API。
