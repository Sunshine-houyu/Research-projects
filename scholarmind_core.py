"""
ScholarMind - 科研多 Agent 协作系统核心代码(节选,已脱敏)
================================================================
适用场景:高校科研团队的文献综述、假设生成、实验设计、论文撰写、自审闭环
作者:某高校博导研究团队
依赖:anthropic >= 0.40.0, asyncio, networkx, sentence-transformers
================================================================
本文件包含三大核心模块:
  1. ResearchAgent          - 单 Agent 长链推理基类
  2. ResearchOrchestrator   - 多 Agent DAG 编排器
  3. multi_persona_review   - 评审反思 Agent 的多 Persona 自审
"""

import asyncio
from typing import List, Dict, Any, Optional
from dataclasses import dataclass, field
from anthropic import AsyncAnthropic

client = AsyncAnthropic()
MODEL = "claude-opus-4-7"


# ============================================================
# 1. 研究 Agent 基类 - 长链推理 + 自我反思
# ============================================================
@dataclass
class AgentMemory:
    """跨任务的长程记忆,基于向量库 + 知识图谱"""
    short_term: List[Dict] = field(default_factory=list)
    long_term_kg: Optional[Any] = None       # 知识图谱句柄
    embedding_index: Optional[Any] = None    # 向量索引句柄


class ResearchAgent:
    """
    单个科研 Agent 的基类。
    核心能力:
      - 长链推理(最多 8 轮自我反思)
      - 工具并行调度(学术 API、Python sandbox、KG 查询)
      - 跨 Agent 共享记忆
    """

    def __init__(self, name: str, system_prompt: str, tools: List[Dict],
                 memory: AgentMemory):
        self.name = name
        self.system_prompt = system_prompt
        self.tools = tools
        self.memory = memory
        self.reflection_count = 0
        self.token_usage = 0

    async def run(self, task: str, context: Dict) -> Dict[str, Any]:
        messages = self._build_messages(task, context)

        for round_idx in range(8):  # 最多 8 轮反思修正
            resp = await client.messages.create(
                model=MODEL,
                max_tokens=4096,
                system=self.system_prompt,
                tools=self.tools,
                messages=messages,
            )
            self.token_usage += resp.usage.input_tokens + resp.usage.output_tokens

            # 工具调用 -> 并行执行 -> 回填结果
            if resp.stop_reason == "tool_use":
                tool_results = await self._dispatch_tools(resp.content)
                messages.append({"role": "assistant", "content": resp.content})
                messages.append({"role": "user", "content": tool_results})
                continue

            # 自我批判
            critique = await self._self_critique(resp.content, context)
            if critique["passed"]:
                self._persist_to_memory(messages[-4:])
                return {
                    "agent": self.name,
                    "output": resp.content,
                    "rounds": round_idx + 1,
                    "tokens": self.token_usage,
                }

            # 未通过 -> 拼接反思意见再来一轮
            messages.append({
                "role": "user",
                "content": f"自审未通过,反思意见: {critique['feedback']}, 请改进输出。"
            })
            self.reflection_count += 1

        return {"agent": self.name, "output": resp.content, "rounds": 8}

    async def _self_critique(self, output, context: Dict) -> Dict:
        """三维评分:可证伪性 / 创新性 / 可行性"""
        prompt = f"""
        以严格的科研标准评估以下产出:
        ---
        {output}
        ---
        从【可证伪性】【创新性】【可行性】三维度各打 1-10 分,
        总分 < 24 视为未通过,需返回具体改进意见。
        """
        resp = await client.messages.create(
            model=MODEL, max_tokens=800,
            messages=[{"role": "user", "content": prompt}],
        )
        # 简化:实际实现中会做结构化解析
        text = resp.content[0].text if resp.content else ""
        passed = "总分" in text and any(s in text for s in ["24", "25", "26", "27", "28", "29", "30"])
        return {"passed": passed, "feedback": text}

    async def _dispatch_tools(self, content) -> List[Dict]:
        """并行调度工具:学术 API / Python sandbox / KG / 文献库"""
        tasks = [self._call_one_tool(block) for block in content
                 if block.type == "tool_use"]
        return await asyncio.gather(*tasks)

    async def _call_one_tool(self, block) -> Dict:
        # 这里根据 block.name 路由到具体的工具实现
        ...

    def _build_messages(self, task: str, context: Dict) -> List[Dict]:
        return self.memory.short_term + [{"role": "user", "content": task}]

    def _persist_to_memory(self, recent: List[Dict]):
        self.memory.short_term.extend(recent)
        # 实际实现中还会把要点写入向量索引和知识图谱


# ============================================================
# 2. 多 Agent DAG 编排器
# ============================================================
class ResearchOrchestrator:
    """
    科研多 Agent 编排器:DAG 式长链协作。
    支持动态回溯:评审反思 Agent 判定 Major Revision 时,
    自动回写到上游 Agent 重新执行。
    """

    def __init__(self):
        shared_memory = AgentMemory()
        self.agents = {
            "literature": ResearchAgent("文献检索 Agent", LIT_PROMPT, LIT_TOOLS, shared_memory),
            "hypothesis": ResearchAgent("假设生成 Agent", HYP_PROMPT, HYP_TOOLS, shared_memory),
            "experiment": ResearchAgent("实验设计 Agent", EXP_PROMPT, EXP_TOOLS, shared_memory),
            "analysis":   ResearchAgent("数据分析 Agent", ANA_PROMPT, ANA_TOOLS, shared_memory),
            "writing":    ResearchAgent("论文撰写 Agent", WRT_PROMPT, WRT_TOOLS, shared_memory),
            "review":     ResearchAgent("评审反思 Agent", REV_PROMPT, REV_TOOLS, shared_memory),
        }
        self.shared_memory = shared_memory

    async def run_pipeline(self, topic: str, target_journal: str = "Nature Communications") -> Dict:
        ctx = {"topic": topic, "target_journal": target_journal, "trace": []}

        # 阶段 1:文献综述
        lit = await self.agents["literature"].run(
            f"对 [{topic}] 进行系统综述,产出研究脉络图与空白点。", ctx)
        ctx["literature"] = lit
        ctx["trace"].append(("literature", lit["rounds"]))

        # 阶段 2:假设生成
        hyp = await self.agents["hypothesis"].run(
            f"基于综述空白,生成 5 个互斥的可证伪假设。", ctx)
        ctx["hypotheses"] = hyp
        ctx["trace"].append(("hypothesis", hyp["rounds"]))

        # 阶段 3:并行实验设计(每个假设一组)
        hypotheses_list = self._split_hypotheses(hyp["output"])
        exp_tasks = [self.agents["experiment"].run(
            f"为以下假设设计可执行实验方案:{h}", ctx) for h in hypotheses_list]
        experiments = await asyncio.gather(*exp_tasks)
        ctx["experiments"] = experiments

        # 阶段 4:撰写 ↔ 评审 闭环(最多 3 轮 Major Revision)
        for round_idx in range(3):
            draft = await self.agents["writing"].run(
                f"按 {target_journal} 风格撰写论文初稿。", ctx)
            ctx["draft"] = draft

            review = await self.agents["review"].run(
                f"以三位审稿人视角对初稿进行评审。", ctx)
            ctx["review"] = review

            decision = self._parse_decision(review["output"])
            if decision == "Accept":
                break
            ctx["revision_notes"] = review["output"]
            # Major Revision 触发上游 Agent 补做实验
            if decision == "Major" and round_idx < 2:
                await self.agents["experiment"].run(
                    f"根据审稿意见补充实验:{ctx['revision_notes']}", ctx)

        return ctx

    def _split_hypotheses(self, raw) -> List[str]:
        # 简化实现
        return [f"假设_{i}" for i in range(5)]

    def _parse_decision(self, review_output) -> str:
        # 简化实现:从评审输出解析 Accept / Major / Minor
        text = str(review_output)
        if "Accept" in text:
            return "Accept"
        if "Major" in text:
            return "Major"
        return "Minor"


# ============================================================
# 3. 评审反思 Agent - 多 Persona 自审
# ============================================================
PERSONAS = [
    {
        "role": "方法学审稿人",
        "focus": "实验设计严谨性、统计功效、对照组设置、可重复性、混杂因素控制",
    },
    {
        "role": "领域专家审稿人",
        "focus": "文献覆盖度、创新性定位、与 SOTA 的差距、理论贡献、概念清晰度",
    },
    {
        "role": "应用价值审稿人",
        "focus": "实际场景落地、社会经济效益、政策启示、可推广性、伦理考量",
    },
]


async def multi_persona_review(draft: str, target_journal: str) -> Dict:
    """
    模拟三位审稿人对初稿独立评审,再由元评审 Agent 汇总形成可执行修改清单。
    这是整个 ScholarMind 系统中 Token 消耗最大的环节(单次约 60 万 Token)。
    """
    reviews = []
    for persona in PERSONAS:
        prompt = f"""你是 {target_journal} 的{persona['role']}。
重点关注:{persona['focus']}。

请阅读以下论文初稿,完成两件事:
1. 给出 Major Revision / Minor Revision / Accept 三选一决定;
2. 列出 5-10 条具体、可执行的修改意见(禁止空泛评论)。

--- 初稿开始 ---
{draft}
--- 初稿结束 ---
"""
        resp = await client.messages.create(
            model=MODEL,
            max_tokens=3000,
            messages=[{"role": "user", "content": prompt}],
        )
        reviews.append({
            "persona": persona["role"],
            "review": resp.content,
        })

    # 元评审:汇总三方意见,形成最终修改清单
    aggregator_prompt = f"""
以下是三位审稿人对同一篇初稿的独立评审意见:
{reviews}

请你作为责任编辑,汇总三方意见,产出:
1. 最终决定(Major / Minor / Accept)
2. 加权后的修改清单(去重 + 优先级排序)
3. 对作者的总体反馈(200 字)
"""
    final = await client.messages.create(
        model=MODEL,
        max_tokens=2000,
        messages=[{"role": "user", "content": aggregator_prompt}],
    )

    return {
        "individual_reviews": reviews,
        "aggregated_decision": final.content,
    }


# ============================================================
# 入口示例
# ============================================================
async def main():
    orch = ResearchOrchestrator()
    result = await orch.run_pipeline(
        topic="基于图神经网络的蛋白质-配体相互作用预测",
        target_journal="Nature Communications",
    )
    print("Pipeline 完成,trace:", result["trace"])


if __name__ == "__main__":
    asyncio.run(main())
