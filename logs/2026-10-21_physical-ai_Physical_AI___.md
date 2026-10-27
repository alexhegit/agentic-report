---
id: 17abfd_2026-10-21
date: 2026-10-21
title: Physical AI 日报
type: 日报
---

## 🤖 Physical AI 日报 [2026-10-21]

### 🔥 热门开源项目
- **Action Atlas (CWRU-AISM)** - VLA 模型可解释性平台：520+ SAE 解码器可视化，证明 π0.5 的任务程序绑定在绝对坐标空间而非视觉场景（UR10e 物理验证），NeurIPS 2026 [GitHub](https://github.com/CWRU-AISM/action-atlas)
- **Stanford-TML/FoveaVLA** - 新开源项目：用"视差动作"（foveation actions）替代手腕相机输入，降低 VLA 传感依赖 [GitHub](https://github.com/Stanford-TML/FoveaVLA)
- **XsparkAI/Spark-0** - 面向灵巧操作的空间对齐触觉预训练，新仓快速起量 [GitHub](https://github.com/XsparkAI/Spark-0)

### 📄 重要论文 / 预印本
- **VQ-WM: Vector-Quantized World Model** - 离散潜空间搜索+连续视觉反馈控制结合，汉诺塔真机 100% 成功率（超越 VLA/WAM 基线），sim 基准领先最强世界模型 13~85pp [arXiv](https://arxiv.org/abs/2610.25600)
- **NestedVLA** (NeurIPS 2026) - 超网络生成动作专家权重更新，无需原始数据即可整合多个微调 VLA 策略，比最强模型合并基线高 41.1pp [arXiv](https://arxiv.org/abs/2610.23271)
- **ASENA (NVIDIA)** - 编码智能体在线编写/进化机器人导航程序，Unitree G1 上无预建地图完成拾取-搬运-交接，R2R 成功率 72%→98% [arXiv](https://arxiv.org/abs/2609.39207)

### 🏢 行业动态
- Gecko Robotics - 与美国海军签署 $300M 合同，国防机器人采购持续放量
- Kodama - 融资 $7M 进军林业机器人；RoboBusiness 更名 Robotics Summit & Expo West

### 💡 值得关注
本周 VLA 研究明显向两个方向收敛：一是**推理效率/延迟鲁棒**（PACT-VLA、DEFLECT、VLA-Rolling 均围绕异步推理下的动作块复用与旧观测修正）；二是**机制可解释性**（Action Atlas 类工作开始打开 VLA 黑箱）。世界模型侧"离散搜索+连续控制"混合范式（VQ-WM）展现出对长程任务的可组合性优势，值得跟进。
