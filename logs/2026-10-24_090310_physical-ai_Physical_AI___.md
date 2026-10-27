---
id: e3325c_2026-10-24_090310
date: 2026-10-24
title: Physical AI 周报
type: 周报
---

## 🤖 Physical AI 周报 [2026-10-17 ~ 2026-10-24]

### 🌟 TOP 开源项目
1. **kyutai-labs/reki** — Kyutai 开源 2.4B VLA 模型，仅用公开数据预训练、含记忆模块。[github.com/kyutai-labs/reki](https://github.com/kyutai-labs/reki)
2. **rzc156/dreamforge** — 把世界模型"想象"生成纠偏训练数据，单卡可跑。[github.com/rzc156/dreamforge](https://github.com/rzc156/dreamforge)
3. **AutoLab-SAI-SJTU/WAVE-0** — 用轻量潜变量未来动作桥接 VLA 与世界模型。[github.com/AutoLab-SAI-SJTU/WAVE-0](https://github.com/AutoLab-SAI-SJTU/WAVE-0)
4. **Stanford-TML/FoveaVLA** — 用"凝视聚焦"动作替代腕部相机做多视角 VLA。[github.com/Stanford-TML/FoveaVLA](https://github.com/Stanford-TML/FoveaVLA)
5. **opentac/opentac** — 柔性 PCB 触觉皮肤设计/仿真开源生态，配套论文同步上线 arXiv 2610.31661。[github.com/opentac/opentac](https://github.com/opentac/opentac)

### 📄 TOP 论文
1. **HEX** — 人形对齐专家做跨本体全身操作，SOTA 成功率。[arxiv.org/abs/2604.07993](https://arxiv.org/abs/2604.07993v3)
2. **WholeBodyMem (Memory before Goal)** — 让 VLA 记住目标物"前史"，Unitree G1 真机成功率 36.7%→88.3%。[arxiv.org/abs/2610.31166](https://arxiv.org/abs/2610.31166v1)
3. **Beyond Imitation: RL Sim-Real Co-Training** — OpenVLA/π0.5 上真机 +24%，摆脱对演示数据依赖。[arxiv.org/abs/2602.12628](https://arxiv.org/abs/2602.12628v5)
4. **FocusVLA** — 未来意图驱动的动态视角路由，RoboTwin 上较 π0.5 +10pp。[arxiv.org/abs/2610.31423](https://arxiv.org/abs/2610.31423v1)
5. **NVIDIA ASPIRE** — Agentic 技能发现，code-as-policy，LIBERO-Pro 用 Opus 5.5 达 99%。[arxiv.org/abs/2607.00272](https://arxiv.org/abs/2607.00272v2)

### 🏢 行业动态
- **Eka Robotics**（MIT Pulkit Agrawal）：a16z 领投 $150M、估值 $1.45B，视觉-力-动作模型可达 1500 件/小时。[TechCrunch](https://techcrunch.com/2026/10/20/eka-is-worth-1-45-billion-thanks-to-a-physical-ai-model-that-has-experts-raving)
- **Enact Intelligence**（苏黎世）：出隐身获 $30M pre-seed，力在作动器内感知；天使含 Yann LeCun、Arthur Mensch、Thomas Wolf。[Unite.AI](https://unite.ai/enact-intelligence-raises-30m-pre-seed-for-force-and-touch-robot-dexterity)
- **Formic**：$50M Series B，从任务级自动化扩张到通用机器人 RaaS。[BusinessWire](https://finance.yahoo.com/technology/ai/articles/formic-raises-50-million-scale-200000520.html)
- **Agility Digit**：AGCO 堪萨斯农场工厂落地部署。[RobotReport](https://www.therobotreport.com/agco-to-deploy-agility-digit-humanoid-in-kansas-f)
- **Gecko Robotics**：获美国海军 $300M 合同。[RobotReport](https://www.therobotreport.com/gecko-robotics-earns-300m-contract-with-the-u-s-n)

### 🔍 趋势分析
力/触觉作为第三模态正在成为 dexterity 的竞争焦点（Eka、Enact、OpenTac/GelSlim 同周出现），资本同时押注"作动器内传感"与"力敏感夹爪"两条硬件路径。研究侧从"VLA 精度"转向"训练数据从哪来"：世界模型 + 在线 RL 生成纠偏数据（DreamForge/WAVE-0/RL-Co）与 Agentic skill discovery（ASPIRE/FastHarness）共同指向用基础模型自举数据、压缩真机演示成本这条新主线。

### 💡 下周关注
- **RoboBusiness / Robotics Summit & Expo West** 后续落地项目与发布；
- **FCC 机器人新规则**对自动化采购的影响研讨会与后续政策；
- **NVIDIA ASPIRE** 的 NVlabs/ASPIRE 开源代码发布与 API 可用性。
