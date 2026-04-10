# AGENTS.md
|IMPORTANT: Prefer retrieval-led reasoning over pre-training-led reasoning for any project tasks.
|Project:codex-tokens-compress
|Primary Goal:Compress AGENTS.md into high-density index rules|increase instruction hit rate|reduce hallucination|save token usage.
|Language Policy:规则说明默认中文|path/command/file/code-id保持英文|mandatory IMPORTANT line保留英文原文.
|Repo Root:./:{.agents,.codex}
|Local Skills:.agents/skills:{agents-md-compress,skill-creator}
|Skill Trigger:Use agents-md-compress when request mentions AGENTS.md creation, compression, or rule updates.
|Official Dir Facts:repo skills=`.agents/skills`|user skills=`$HOME/.agents/skills`|admin skills=`/etc/codex/skills`|system skills are built in Codex.
|Official Dir Facts:project subagents=`.codex/agents`|user subagents=`~/.codex/agents`.
|Official Dir Facts:mcp/config=`~/.codex/config.toml` or `.codex/config.toml`|trusted project loads `.codex/config.toml` from repo root to cwd|nearer directory overrides farther directory.
|Project Constraint:This repo stores project configuration in `.codex/config.toml` and project skills in `.agents/skills`.
|Compression Format:line-1 must be title|all non-empty lines after title must start with `|`|prefer `Category:path:{...}` and `Category:value1|value2`.
|Allowed Content:structure|commands|constraints|verification gates|PR checklist.
|Forbidden Content:long narrative|tutorial-style explanation|code fence|`##`|`###`.
|Anti Hallucination:Never invent paths, commands, rules, or tool outputs.
|Anti Hallucination:If a fact cannot be verified from repository files, mark it as `Unknown` and request confirmation before execution.
|Anti Hallucination:Validate key paths and commands before writing or updating index lines.
|Evidence Priority:repo files > existing AGENTS.md > local skill references > user explicit input.
|Command Index:Validate=`python .agents/skills/agents-md-compress/scripts/example.py AGENTS.md`
|Fallback Validate:check title|check IMPORTANT line|check prefix `|`|check no `##`/`###`/code fence.
|Token Strategy:one-line-one-rule|merge same-type short rules|delete duplicate wording|avoid examples unless requested.
|Output Strategy:default concise|only actionable facts|no repeated context.
|Change Workflow:extract highest-priority facts|rewrite to index lines|run validation|fix failures.
|PR Checklist:scope of rule changes|validation evidence|risk note.
|Maintenance Trigger:new module or renamed path|build/test command changed|non-empty lines exceed 35.
|Owner:Maintainers update this file when workflow, structure, or constraints change.
