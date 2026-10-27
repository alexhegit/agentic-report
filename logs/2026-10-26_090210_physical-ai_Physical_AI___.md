---
id: 17abfd_2026-10-26_090210
date: 2026-10-26
title: Physical AI 日报
type: 日报
---

I have enough grounded data to compose the digest. Here's today's report.

## 🤖 Physical AI 日报 [2026-10-26]

### 🔥 热门开源项目
- **EagleVLA**（CoRL 2026 Spotlight）— 面向 Jetson Orin 的 VLA 板端实时推理，用"未来对齐的异步推理"+ llama.cpp 引擎把控制频率提 **14.7x**，LIBERO 成功率超 VLASH 14.8% [github/PKU-SEC-Lab/EagleVLA](https://github.com/PKU-SEC-Lab/EagleVLA)
- **FluxVLA Engine** — 配置驱动的一站式 VLA/世界模型工程平台，打通数据→训练→仿真→板端部署全流程，含双臂仿真与实时 chunking [github/FluxVLA/FluxVLA](https://github.com/FluxVLA/FluxVLA)

### 📄 重要论文 / 预印本
- **UniFlowWAM** — 让 3D 场景流成为与"视觉、动作"并列的第三模态统一世界-动作模型；真实双手机器人成功率 **87.0%**，远超最强基线 68.5%（RoboCasa-GR1 上基线 52.1%→56.4%）[arXiv 2610.30991](https://arxiv.org/abs/2610.30991)
- **CW-WAM** — 力-接触统一世界动作模型并预测接触 wrench，方孔（1mm 间隙）插入成功率 **25%→70%**、电源适配器 **40%→95%** [arXiv 2610.30117](https://arxiv.org/abs/2610.30117)
- **WAM-TTT** — 测试时训练框架，冻结 WAM 仅凭"裸人类视频"自适应记忆即可转向新任务，无需机器人动作或任务微调 [arXiv 2607.06988](https://arxiv.org/abs/2607.06988)
- **Full-Weight VLA Fine-Tuning Without fp32 Master Copy**（实用警告）— 9/12 开源 VLA 代码默认 bf16 全量微调会**静默抹掉 ≥79% 的梯度更新**；加一行 fp32 master 即大幅涨点（π0.5 5.1%→80.9%）[arXiv 2610.31859](https://arxiv.org/abs/2610.31859)

### 🏢 行业动态
- **Eka Robotics** — 融资 **$150M**，扩展其"视觉-力-动作"（vision-force-action）机器人大模型
- **Teradyne Robotics × Sereact** — 战略合作，将 Physical AI 落地零售与物流
- **AGCO** — 在堪萨斯工厂部署 **Agility Digit** 人形机器人

### 💡 值得关注
- 今日本土信号：**世界-动作模型（WAM）持续"模态融合化"**——3D 流、接触 wrench、代码技能相继被拉进统一架构，而非外挂模块；同时 **VLA 部署侧**（板端推理、bf16 精度陷阱、推理时纠偏）正成为落地瓶颈，工程化 > 刷分。
