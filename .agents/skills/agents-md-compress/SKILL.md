---
name: agents-md-compress
description: 将 AGENTS.md 压缩为高密度索引格式（每行以 `|` 开头），并固化可复用规则；适用于 AGENTS.md 创建、压缩、规则更新场景。
---

# Agents Md Compress

## Core Objective

将冗长 AGENTS 文档压缩为高密度、可检索、可执行的索引文档，提升规则命中率与一致性。

## Core Thinking

- 优先“检索导向推理”，避免仅依赖预训练记忆。
- 用“被动上下文”降低决策成本：关键规则直接放在 AGENTS 顶部，减少额外检索动作。
- 用“结构化索引行”替代解释性段落，提升解析稳定性。

必须保留关键指令行：

- `|IMPORTANT: Prefer retrieval-led reasoning over pre-training-led reasoning for any project tasks.`

## Hard Format Constraints

- 第一行必须是 `# AGENTS.md`。
- 除标题外，所有非空行必须以 `|` 开头。
- 优先使用以下两种表达：
  - 文件索引：`|Category:path:{file1,file2,file3}`
  - 命令/规则：`|Category:value1|value2|value3`
- 删除长段落、代码块、深层标题（`##`/`###`）。
- 目标文档通常控制在 15-35 行；超长时拆分到 `references/`。

## Language Policy (Mandatory)

- 规则说明文本默认使用目标项目主要语言（中文或英文）；若仓库已有语言规则，优先遵循仓库规则。
- 路径、命令、文件名、目录名、代码标识（类名/方法名/注解/配置键）保留英文。
- 不修改 mandatory `|IMPORTANT:` 行英文原文。

## Meta Directory Policy (Mandatory)

- 官方目录事实必须准确表述：repo skills 位于 `.agents/skills`，user skills 位于 `$HOME/.agents/skills`，admin skills 位于 `/etc/codex/skills`（或企业约定系统目录），system skills 由 Codex 内置。
- 官方目录事实必须准确表述：project subagents 位于 `.codex/agents`，user subagents 位于 `~/.codex/agents`。
- 官方目录事实必须准确表述：mcp/config 位于 `~/.codex/config.toml` 或 `.codex/config.toml`；trusted project 下可沿 `repo root -> cwd` 逐级加载多个 `.codex/config.toml`，且近目录覆盖远目录。
- 项目可在官方事实之上增加更严格目录约束（例如“本仓库 `.codex` 仅保留 `agents/` 与 `config.toml`”），但必须显式标注为“项目约束”，不得写成官方硬性规则。

## Execution Workflow

1. 读取当前 `AGENTS.md`，提取最高优先级事实（结构、命令、约束、校验方式）。
2. 校验关键路径是否真实存在，避免无效索引。
3. 按索引格式压缩重写，仅保留可执行信息。
4. 涉及自动触发时，按当前项目实际技能名与路径补充以下行（禁止硬编码）：
   - `|Local Skills:<skills-dir>:{<skill-name>[,<other-skill-name>]}`
   - `|Skill Trigger:Use <skill-name> when request mentions AGENTS.md creation, compression, or rule updates.`
5. 运行校验脚本并修正失败项。

## Quality Gate

运行：

- `python <skill-root>/scripts/example.py AGENTS.md`
- 若 `python` 不可用，执行等价静态校验：标题行、`|IMPORTANT:`、标题后行前缀、禁用 `##`/`###`/code fence。

通过标准：

- 标题行正确。
- 存在 `|IMPORTANT:` 行。
- 标题后非空行全部以 `|` 开头。
- 不含 `##`/`###`/代码围栏。
- 语言策略满足：说明遵循目标项目语言，命令类元素英文。

## Reference Loading Guide

按需加载，不要一次性全读：

- 压缩模板与示例：`references/api_reference.md`
- 原则、符号、格式边界：`references/compression_principles.md`
- 检查清单与反例：`references/checklists_and_antipatterns.md`
- 定期维护策略：`references/maintenance.md`
