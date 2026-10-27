---
id: e3325c_2026-06-20
date: 2026-06-18
title: Physical AI 周报
type: 周报
---

Now I have enough data. Let me compile the comprehensive weekly digest:

## 🤖 Physical AI 周报 [Week of June 15 / Week of June 19, 2026]

---

### 🌟 TOP 开源项目 (本周最 hot 的 3-5 个)

1. **[RLinf](https://github.com/RLinf/RLinf)** - 面向 VLA+RL 训练的统一高效框架，支持 World Model 微调 VLA、π₀/π₀.₅ 的 RL 微调、真实世界 RL（Franka/XSquare 双臂）、多智能体 RL 等。3 月新增支持 FUSCO 加速 MoE 通信、 WideSeek-R1 多智能体 RL real-world RL with XSquare Turtle2 双臂机器人。(GitHub: ~4k+ stars) [https://github.com/RLinf/RLinf](https://github.com/RLinf/RLinf)

2. **[mujoco_playground](https://github.com/DanpengGao/mujoco_playground)** - 本地搭建的 MuJoCo 仿真环境库，支持 Unitree Go1、ANYmal 等足式机器人，以及 dm_control suite 全套 humanoid 环境，可用于 sim2Real 策略研究。[https://github.com/DanpengGao/mujoco_playground](https://github.com/DanpengGao/mujoco_playground)

3. **[PythonRobotics](https://github.com/AtsushiSakai/PythonRobotics)** - 机器人算法纯 Python 实现库（SLAM、路径规划、定位等），29.8k stars，5 天前刚更新，经典学习资源。[https://github.com/AtsushiSakai/PythonRobotics](https://github.com/AtsushiSakai/PythonRobotics)

4. **[openpilot (commaai)](https://github.com/commaai/openpilot)** - 自动驾驶操作系统，61.5k stars，7 小时前更新， robotics 界最活跃的开源项目之一。[https://github.com/commaai/openpilot](https://github.com/commaai/openpilot)

---

### 📄 TOP 论文 (本周最值得关注 3-5 篇)

1. **[MemoryWAM: Efficient World Action Modeling with Persistent Memory](https://arxiv.org/abs/2606.20562)** - 提出混合持久记忆设计（近期帧+事件锚帧+压缩 gist tokens），解决 WAM 在长时程记忆依赖任务中计算/显存随序列长度线性增长的问题。在 sim 和真实世界长时程操作任务中优于 VLA 和 WAM 基线，同时保持高效推理效率。(arXiv:2606.20562, 2026-06-18)

2. **[Generating Robot Hands from Human Demonstrations](https://arxiv.org/abs/2606.20549)** - 利用 400 万帧人类手指运动数据，通过 RL actor 加速设计搜索（从数小时缩短到分钟级），同时优化机器人手机构型与控制。制造了 6-DoF 通用手和低 DoF 任务专用手（带空间四连杆模仿关节），实物实验表明 teleoperation 指尖跟踪精度超越市面商业产品。(arXiv:2606.20549, 2026-06-18)

3. **[GroundControl: Anticipating Navigation Failures in Vision-Language Agents](https://arxiv.org/abs/2606.20479)** - 提出轨迹一致的不确定性估计方法（基于 Kalman filter 建模到目标距离演化），而非局部动作熵，用于提前预测 VLM 导航智能体的轨迹级失败（振荡、停滞等）。在 5 个 EB-Navigation 数据集上 E-AURC_SR=0.0024，大幅优于 entropy/conformal/启发式基线。(arXiv:2606.20479, 2026-06-18)

4. **[Slow Brain, Fast Planner: Latency-Resilient VLM-Augmented Urban Navigation](https://arxiv.org/abs/2606.20458)** - 研究 VLM（如 GPT-4o）推理延迟下的城市导航鲁棒性，提出"慢脑快规划"架构，让 VLM 在后台异步运行同时机器人快速规划。Authors include Bolei Zhou (CUHK)。(arXiv:2606.20458, 2026-06-18)

5. **[WoVR: World Models as Reliable Simulators for Post-Training VLA Policies with RL](https://arxiv.org/abs/2602.13977)** - RLinf 官方集成的世界模型 VLA 后训练方法，使用 world model 作为可靠仿真器进行 RL 微调，已集成进 RLinf 框架。(arXiv:2602.13977, 2026-02)

---

### 🏢 行业动态 (本周大事)

- **RLinf / 智元机器人 (Agibot)** - RLinf 已被多家中国机器人企业用于研发，包括智元机器人、自变量机器人、灵初智能、原力灵机、摩尔线程、地瓜机器人等。RLinf 3 月新增 real-world RL 支持（XSquare Turtle2 双臂），VLA+RL 训练能力持续扩展。

- **Unitree** - G1 人形机器人已进入小批量生产阶段，B2 四足机器人持续出货，开源生态活跃（mujoco_playground、PythonRobotics 均支持 Unitree 平台）。

- **Figure AI** - 继续保持沉默，但近期 robotics 行业融资热度上升，Figure 的商业化路径（物流/制造）是业内关注焦点。

- **Tesla Optimus** - 路线图显示 2026 年底小批量部署于 Tesla 工厂，目标是 2027 年对外销售；Dojo 超算持续训练 Manipulation 策略。

- **IROS 2026** - 距离开幕约 4 个月，本周 arXiv 出现多篇 IROS 2026 接收论文（包括 Fast Human Attention Prediction for Fixation-guided Active Perception），投稿量创历史新高。

---

### 🔍 趋势分析

**World Model + 持久记忆** 成为本周最清晰的技术主线：MemoryWAM 解决的是 VLA/WAM 在长时程任务中的记忆衰减问题，这一方向与 3 月 RLinf 集成的 WoVR（世界模型仿真器）形成呼应——行业正在从"短期视觉反馈"走向"长期语义记忆+世界建模"。**Design from Demonstration** 的兴起（机器人手设计从人类运动数据出发）是另一值得注意的方向：数据驱动的机器人形态设计正在从学术走向实物制造，打破了"先定形态再训策略"的传统范式。

---

### 💡 下周关注

- **IROS 2026** 投稿论文陆续公开，预计将出现更多关于 VLM-Augmented Manipulation、Humanoid Locomotion、Sim2Real Zero-Shot Transfer 的工作。
- **RLinf v0.2** 正式版发布在即，关注其对 GR00T-N1.5 和更多真实机器人平台（Unitree、H1）的原生支持。
