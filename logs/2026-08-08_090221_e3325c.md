---
id: e3325c_2026-08-08_090221
date: 2026-08-08
title: Physical AI 周报
type: 周报
---

## 🤖 Physical AI 周报 [Week of 2026-08-03 ~ 08-08]

### 🌟 TOP 开源项目（本周最 hot）
1. **TurboVLA** — 实时 VLA 新标杆：RTX 4090 上 32Hz 推理、显存 <1GB，边缘部署友好（⭐401，两周内）https://github.com/H-EmbodVis/TurboVLA
2. **τ0-VLA** — 分层机器人基础模型，引入"世界模型引导的 test-time computation"，推理时做规划搜索（⭐353）https://github.com/sii-research/tau-0-vla
3. **INTACT-JEPA**（浙大 ZJU3DV）— JEPA 路线的 search-free 世界模型，意图到动作同构学习 https://github.com/zju3dv/INTACT-JEPA
4. **VisTouch** — 大规模视觉-触觉-音频同步滑动接触数据集，补多模态触觉数据缺口（⭐210）https://github.com/liangnjupt/VisTouch
5. **Genesis / LeRobot** 持续高频更新，分别达 ⭐29.7k / 26.5k，仍是 sim 与机器人学习的事实标准

### 📄 TOP 论文（本周值得关注）
1. **ω-0: Latent Predictive World Action Model** — 潜空间预测式世界-动作模型，实现人形机器人并发移动操作（loco-manipulation）https://arxiv.org/abs/2608.06375
2. **DyPES-VLA** — 共享动力学先验 + 本体专属控制，直指跨本体泛化 https://arxiv.org/abs/2608.06374
3. **GeniWorld** — 通过 visual actions 构建可交互、可泛化的操作世界模型 https://arxiv.org/abs/2608.06332
4. **Adaptive-WAM** — 从视频扩散中间特征做质量引导的早退规划，省算力 https://arxiv.org/abs/2608.06008
5. **VIDP** — 可变阻抗扩散策略，从多样示教学习柔顺操作 https://arxiv.org/abs/2608.06210

### 🏢 行业动态
- **Google** — Gemini Robotics 2 发布，扩展人形机器人 AI 能力
- **三菱电机** — 加入人形机器人竞赛，目标月产 1000 台
- **HII（美国军工造船）** — 与 Path Robotics、GrayMatter Robotics 签最高 $900M 协议，焊接/打磨机器人进造船业
- **Zoox** — 发布量产版 robotaxi，启动美国扩张
- **行业报告** — "人形机器人不降本无法规模化进工厂"引发热议，成本成为落地核心议题

### 🔍 趋势分析
本周明显的主线是 **World-Action Model (WAM) 爆发**：ω-0、Adaptive-WAM、Robust-WAM、τ0-VLA 同时出现，VLA 正从"感知-动作映射"演进为"预测-规划一体化"。第二条线是**推理效率**——TurboVLA 的 <1GB 显存和 Adaptive-WAM 的早退机制都指向边缘部署，对国产/AMD GPU 生态是机会窗口。

### 💡 下周关注
- τ0-VLA / TurboVLA 是否放出真机 demo 与权重，验证 test-time compute 的实际收益
- Gemini Robotics 2 的开源策略及与 Figure/Apptronik 等硬件方的适配进展
