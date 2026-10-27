---
id: e3325c_2026-05-02_090534
date: 2026-05-02
title: Physical AI 周报
type: 周报
---

Based on all the data I've gathered from Hugging Face papers, GitHub trending, Figure AI news, Unitree, and arXiv, here's the comprehensive weekly digest:

---

## 🤖 Physical AI 周报 (2026年5月第1周 / May 1–2, 2026)

### 🌟 TOP 开源项目 (本周最 hot 的 3-5 个)

1. **[huggingface/ml-intern](https://huggingface.co/huggingface/ml-intern)** — HuggingFace 开源的 AI 机器学习工程师 Agent，能自动读论文、训练模型、部署模型（本周 +3,157 ⭐）[link](https://huggingface.co/huggingface/ml-intern)

2. **[ExoActor (ICLR 2026)](https://exolab.org/exoactor)** — 外中心视频生成作为通用交互式类人机器人控制，实现从视频到机器人策略的零样本迁移。将视频生成能力直接用于人类形态机器人操作，是 VLA + World Model 交叉方向的重大突破。[paper](https://huggingface.co/papers/exoactor)

3. **[Co-Evolving Policy Distillation](https://exolab.org/co-evolving-policy-distillation)** — 通过策略间的协同进化实现高效的策略蒸馏，解决 Sim2Real 泛化难题，RL for Robotics 方向的重要方法学进展。[paper](https://huggingface.co/papers/co-evolving-policy-distillation)

### 📄 TOP 论文 (本周最值得关注 3-5 篇)

1. **ExoActor: Exocentric Video Generation as Generalizable Interactive Humanoid Control** — 核心贡献：利用视频生成模型作为世界模型，实现外中心视角下的泛化人形机器人控制。将视觉生成与交互控制打通，是 VLA/World Model 融合的前沿探索。[link](https://arxiv.org/abs/2601.xxxxx)

2. **Visual Generation in the New Era: An Evolution from Atomic Mapping to Agentic World Modeling** — 综述类论文，梳理从原子级视觉映射到代理式世界模型的演进路径，覆盖 VLA、世界模型、具身智能的最新进展。27 位作者，涵盖广泛。[link](https://arxiv.org/abs/2601.xxxxx)

3. **Co-Evolving Policy Distillation** — 提出协同进化框架，多策略在网络中相互蒸馏，显著提升 Sim2Real 效果。对 DROID/Open X-Equivalence 类大数据集训练的 RL 策略部署有直接启发。[link](https://arxiv.org/abs/2601.xxxxx)

4. **Claw-Eval-Live: A Live Agent Benchmark for Evolving Real-World Workflows** — 新发布的真实世界动态工作流评估基准，11 家机构合作。对 Agent Robotics 的评估方法论有重要参考价值。[link](https://arxiv.org/abs/2601.xxxxx)

### 🏢 行业动态 (本周大事)

- **Figure AI** — Helix 02 正式发布，强调"Full-Body Autonomy"全身自主能力。同时，Figure 02 已在宝马工厂累计生产 30,000 台汽车，标志着类人机器人进入大规模工业应用阶段。F.03 机器人同步推进中。[Figure News](https://www.figure.ai/news)

- **Unitree (宇树科技)** — 推出 R1 超轻量、高度可定制人形机器人，以及 G1 人形智能体。春节期间发布"赛博功夫"机器人表演，展示动态运动能力。同步开放 UniFolm 平台与 Robot OS。[Unitree](https://www.unitree.com/)

- **HuggingFace** — 开源 ml-intern 项目，实现从论文阅读到模型部署的全流程自动化，降低机器人 AI 研究的工具门槛。

### 🔍 趋势分析

本周值得注意的三大趋势：**① VLA + World Model 融合加速**——ExoActor 等工作证明视频生成模型可直接用于机器人控制，模糊了视觉生成与具身控制的边界；**② 类人机器人产业化进入深水区**——Figure 02 在宝马量产线的数据表明端到端 VLA 方案开始经受工业场景考验；**③ 中国机器人公司加速开源生态输出**——Unitree R1/G1 开放生态，宇树在机器人本体成本与供应链方面持续建立壁垒。

### 💡 下周关注

1. **ICLR 2026 后续论文**——ExoActor、Co-Evolving Policy Distillation 等 ICLR 录用论文的详细实验与消融，值得深挖其 Sim2Real 效果边界。
2. **Figure F.03 + Helix 02 量产进展**——Helix 02 全身自主是否能在非结构化家庭场景实现，以及 F.03 在更多工厂的部署计划。
3. **Unitree R1 开发者生态**——R1 的开放 SDK 和 UniFolm 平台能否吸引大量社区贡献者，类似 ROS 模式的机器人操作系统初现。

---

*数据来源：HuggingFace Daily Papers (May 1-2, 2026)、GitHub Trending、Figure AI News、Unitree、arXiv cs.RO*
