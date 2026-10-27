---
id: e3325c_2026-06-06
date: 2026-06-06
title: Physical AI 周报
type: 周报
---

## 🤖 Physical AI 周报 [Week of 2026-06-06]

### 🌟 TOP 开源项目（本周最 hot 的 5 个）
1. **[enactic/openarm](https://github.com/enactic/openarm)** - 全开源人形手臂，主打 contact-rich physical AI；适合做操作臂/触觉/部署栈实验（GitHub: 2544★）
2. **[YanjieZe/awesome-humanoid-robot-learning](https://github.com/YanjieZe/awesome-humanoid-robot-learning)** - 人形机器人学习论文索引，本周仍在高频更新，追踪 CoRL/ICRA 线索很实用（GitHub: 2412★）
3. **[YanjieZe/GMR](https://github.com/YanjieZe/GMR)** - General Motion Retargeting，强调实时人形动作重定向，和 TWIST / humanoid 迁移强相关（GitHub: 2302★）
4. **[Roboparty/roboto_origin](https://github.com/Roboparty/roboto_origin)** - 全开源 DIY humanoid 原型，社区热度高，代表“硬件+开源栈”路线（GitHub: 1869★）
5. **[iLearn-Lab/VLA-Diffusion-Policy-Robotics](https://github.com/iLearn-Lab/VLA-Diffusion-Policy-Robotics)** - diffusion policy 在机器人操作上的资源聚合，VLA / manipulation 交叉热点（GitHub: 809★）

### 📄 TOP 论文（本周最值得关注 5 篇）
1. **[HANDOFF: Humanoid Agentic Task-Space Whole-Body Control via Distilled Complementary Teachers](https://arxiv.org/abs/2606.06493)** - 面向人形全身控制，强调 task-space + 蒸馏教师，指向“可部署的 whole-body control”路线
2. **[MoDex: A Diffusion Policy for Sequential Multi-Object Dexterous Grasping](https://arxiv.org/abs/2606.05407)** - 把 diffusion policy 推到连续多物体精细抓取，dexterous manipulation 信号很强
3. **[TempoVLA: Learning Speed-Controllable Vision-Language-Action Policies](https://arxiv.org/abs/2606.06491)** - 解决 VLA 的“速度可控”问题，说明策略不只要会做，还要会按节奏做
4. **[PiL-World: A Chunk-Wise World Model for VLA Policy-in-the-Loop Evaluation](https://arxiv.org/abs/2606.05773)** - world model + policy-in-the-loop 评估，关注闭环与可验证性
5. **[MotionDisco: Motion Discovery for Extreme Humanoid Loco-Manipulation](https://arxiv.org/abs/2606.06139)** - 直接切入 humanoid loco-manip，说明人形研究正从“走路”转向“走+抓+协作”

### 🏢 行业动态（本周大事）
- **研究重心继续向 humanoid loco-manip 倾斜**：本周高频关键词是 whole-body control、dexterous grasp、loco-manip、motion retargeting，说明行业正在从单点能力堆叠走向统一控制栈。
- **VLA / World Model 更强调时序与闭环**：TempoVLA、PiL-World、AffordanceVLA 这类工作表明，策略模型开始补“速度、chunk、affordance、评估闭环”这些工程短板。
- **开源生态仍是最快的信号源**：OpenArm、GMR、roboto_origin 等项目显示，硬件接口、动作重定向、可复现基座仍在快速演进；公开可核实的大厂重磅发布本周相对少，市场焦点更多在研究侧。

### 🔍 趋势分析
本周最明显的信号是：Physical AI 正从“能跑能走”加速转向“能抓、能协同、能长时程执行”。技术上，VLA 不再只追求动作生成，而是在补可控性、时序建模和 policy-in-the-loop 评估；机器人操作则从单臂抓取升级到 humanoid 全身控制与 dexterous manipulation 的统一框架。

### 💡 下周关注
- 继续跟踪 CoRL/ICRA 前后是否会把 **TempoVLA / AffordanceVLA / PiL-World** 这类路线开源化、复现化。
- 重点看 **OpenArm / GMR / roboto_origin** 是否出现更易落地的硬件与控制栈更新。
