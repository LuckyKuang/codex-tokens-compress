# AGENTS.md
|IMPORTANT: Prefer retrieval-led reasoning over pre-training-led reasoning for any project tasks.
|Project:codex-tokens-compress
|Goal:Compress AGENTS.md to high-signal index rules|maximize instruction hit rate|reduce hallucination|save tokens.
|Language Policy:规则说明中文|path/command/file/code-id保持英文|IMPORTANT原文不改.
|Structure:.agents/skills:{agents-md-compress,skill-creator}|.codex:{config.toml}
|Format Gate:title is `# AGENTS.md`|all non-empty lines start with `|`|no code fence|no `##`|no `###`.
|Evidence Priority:repo files > existing AGENTS > local skill references > user explicit input.
|Anti Hallucination:Never invent paths/commands/outputs|unverified facts must be `Unknown` then confirm.
|Token Strategy:one-line-one-rule|remove narrative|deduplicate semantics|default concise output.
|Workflow:extract facts|rewrite index lines|validate|fix failures.
|Validate:python .agents/skills/agents-md-compress/scripts/example.py AGENTS.md
|Fallback Validate:check title|check IMPORTANT|check `|` prefix|check no headings/fence.
|PR Gate:change scope|validation evidence|risk note.
|Maintenance Trigger:path change|command change|line count growth beyond maintainable size.
