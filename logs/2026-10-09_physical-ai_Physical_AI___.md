---
id: e3325c_2026-10-17
date: 2026-10-09
title: Physical AI 周报
type: 周报
---

I have everything I need. Compiling the weekly digest now.

## 🤖 Physical AI 周报 [2026-10-09 ~ 01-16]

### 🌟 TOP 开源项目（本周新建最火）
1. **robosimstudio/robosimstudio** — 物理级 Real2Sim 机械臂操作工具集，人机 + Agent 共用（Apache-2.0，163⭐，10-12 建）[github](https://github.com/robosimstudio/robosimstudio)
2. **rzc156/dreamforge** — 用世界模型"想象"生成纠错训练数据、单卡可跑（SmolVLA·LIBERO·CEM，MIT，130⭐）[github](https://github.com/rzc156/dreamforge)
3. **robot-agent-exploration/rax** — 让 coding agent 在线探索自学习机器人任务的 harness（58⭐）[github](https://github.com/robot-agent-exploration/rax)
4. **hao-ai-lab/ORA** — 开放"Robot-Use Agent"框架（28⭐）[github](https://github.com/hao-ai-lab/ORA)
5. **cocacola-lab/Recursia** — 机器人操作的递归自改进 + 可共享技能（Apache-2.0，17⭐）[github](https://github.com/cocacola-lab/Recursia)

### 📄 TOP 论文（本周 arXiv cs.RO 10-15）
1. **Perceive, Predict, and Plan: Unified World Action Model for Egocentric Dexterous Manipulation** — 单模型统一感/预/规划，面向第一视角灵巧操作 [arxiv](https://arxiv.org/abs/2610.22363v1)
2. **FastVLA: Task-Conditioned & Temporally Adaptive Visual Token Compression** — VLA 视觉 token 压缩提效 [arxiv](https://arxiv.org/abs/2610.22146v1)
3. **Value as Memory: Online Value-Guided Post-training for General Robot Policies** — 价值当记忆做在线后训，附代码 [arxiv](https://arxiv.org/abs/2610.22368v1)
4. **FastVLA 同行 Cross-Embodiment Causal Transfer from Human Videos** — 用人类视频因果迁移到机器人操作 [arxiv](https://arxiv.org/abs/2610.21798v1)
5. **LIBERO-PeRM: Benchmarking Personalized Robotic Manipulation** — 个性化操作基准（NeurIPS 2026，312 任务）[arxiv](https://arxiv.org/abs/2610.22372v1)

### 🏢 行业动态
- **Agility Robotics** — 选 Nyobolt 为 Digit 5 人形配超快充电方案（10-15）
- **Stryker** — 4 亿美元收购/投资 CMR Surgical（10-15）
- **Boston Dynamics** — 公布重新设计的人形手掌更多细节（10-09）
- **Promise Robotics** — 与 D.R. Horton 合作，把 physical AI 落地到住宅建造（10-13）

### 🔍 趋势分析
本周最强信号是 **世界模型与 VLA 全面融合**：统一"世界-动作模型"（WAM）+ 灵巧手 + test-time 验证/优化方法集中爆发，说明行业正从"动作生成"转向"在线自改"。第二条主线是 **灵巧手/操作被公认为真正的瓶颈**（多篇行业文章 + Spark-0 触觉预训练），充电基础设施、住宅/工地等"boring 场景"正成为人形落地的现实切入点。

### 💡 下周关注
- 灵巧手专用模型/数据集与触觉预训练的跟进（对标 Spark-0）
- 人形从"demo"转向"部署"的落地信号：充电、工厂/住宅真实任务数据
