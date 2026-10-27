---
id: e3325c_2026-08-22
date: 2026-08-16
title: Physical AI 周报
type: 周报
---

## 🤖 Physical AI 周报 [Week of 2026-08-16 ~ 08-22]

### 🌟 TOP 开源项目
1. **sii-research/tau-0-vla** — τ₀-VLA：分层机器人基础模型，高层子任务生成引入世界模型引导的 test-time compute，长时序操作新范式（⭐518，新项目）[GitHub](https://github.com/sii-research/tau-0-vla) | [主页](https://tau0-vla.github.io/)
2. **huggingface/lerobot** (v0.6) — 集成 NVIDIA Isaac GR00T 1.7 与 Isaac Teleop，开源机器人学习生态继续扩大（⭐26.8k）[GitHub](https://github.com/huggingface/lerobot) | [NVIDIA Blog](https://blogs.nvidia.com/blog/hugging-face-lerobot-models-frameworks-open-robotics/)
3. **lightwheelai/leisaac** — LeRobot EnvHub 官方 Isaac 仿真 IL 遥操作环境，Sim2Real 工作流加速（⭐718）[GitHub](https://github.com/lightwheelai/leisaac)
4. **Genesis-Embodied-AI/genesis-world** — 通用具身仿真平台持续领跑（⭐29.8k）[GitHub](https://github.com/Genesis-Embodied-AI/genesis-world)

### 📄 TOP 论文
1. **τ₀-VLA: A Hierarchical Robot Foundation Model with World-Model-Guided Test-Time Computation** — 将"推理时计算"引入 VLA 高层规划，闭环成功率显著提升 [arXiv](https://arxiv.org/abs/2608.16885)
2. **HiTac-WAM** — 分层触觉世界动作模型，面向接触丰富的精细操作，触觉+世界模型结合值得跟进 [arXiv](https://arxiv.org/list/cs.RO/recent)
3. **OrthoSkillVLA** — 基于梯度信息子空间适配的 VLA 持续技能学习，缓解灾难性遗忘 [arXiv](https://arxiv.org/list/cs.RO/recent)
4. **Towards Professional Tennis Styles for Humanoid Robots** — 人形机器人全身动态运动控制新标杆（网球风格挥拍）[arXiv](https://arxiv.org/list/cs.RO/recent)
5. **What Matters for Latent Actions in Robot Learning** — 潜动作空间的系统性分析，对 VLA 预训练有指导意义 [arXiv](https://arxiv.org/list/cs.RO/recent)

### 🏢 行业动态
- **宇树科技 (Unitree)** — 8/18 上交所科创板上市，首日暴涨 **460%**（收 845 元），IPO 融资 61 亿元、超额认购逾 8000 倍，成具身智能资本化里程碑 [Bloomberg](https://www.bloomberg.com/news/articles/2026-08-18/unitree-robotics-set-to-debut-after-904-million-shanghai-ipo) | [The Robot Report](https://www.therobotreport.com/)
- **Schaeffler** — 宣布 2027 年量产人形机器人专用减速器，欧洲 Tier-1 正式入局人形供应链 [Robot Report](https://www.therobotreport.com/)
- **Unichem** — 收购 Loomia 加速布局人形机器人"电子皮肤"市场 [Robot Report](https://www.therobotreport.com/)
- **Serve Robotics × Grubhub** — 自动配送机器人扩大商用部署；**Pudu** 发布 MP2000 自主叉车 [Robot Report](https://www.therobotreport.com/)
- **智元 (Agibot)** — 第 15,000 台通用具身机器人下线，量产爬坡持续（背景延续）[PR Newswire](https://www.prnewswire.com/apac/zh/news-releases/15-000-302812696.html)

### 🔍 趋势分析
本周最大信号是**宇树 IPO 首日 +460%**：具身智能从"技术叙事"正式进入资本市场定价阶段，供应链（减速器、电子皮肤）随之受益。技术侧，VLA 正从单体端到端大模型转向**"分层架构 + 世界模型 + test-time compute"**（τ₀-VLA 为代表），触觉模态（HiTac-WAM）和持续学习（OrthoSkillVLA）成为新的研究热点。

### 💡 下周关注
- Unitree 上市后股价走势及产能/订单披露，或带动智元、Figure 估值重估
- RoboBusiness 大会临近，关注 Kollmorgen 人形关节方案与供应链动态
