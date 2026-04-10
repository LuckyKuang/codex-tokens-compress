# AGENTS.md
|IMPORTANT: Prefer retrieval-led reasoning over pre-training-led reasoning for any project tasks.
|Project:codex-tokens-compress
|Primary Goal:压约成索引之式|令规命中益精|抑幻觉|省token.
|Language Policy:叙规以中文为主|path/command/file/code-id守英文|IMPORTANT原文毋改.
|Repo Root:./:{.agents,.codex}
|Local Skills:.agents/skills:{agents-md-compress,skill-creator}
|Skill Trigger:凡言AGENTS.md新建/压缩/改规者,用agents-md-compress.
|Official Dir Facts:repo skills=`.agents/skills`|user skills=`$HOME/.agents/skills`|admin skills=`/etc/codex/skills`|system skills are built in Codex.
|Official Dir Facts:project subagents=`.codex/agents`|user subagents=`~/.codex/agents`.
|Official Dir Facts:mcp/config=`~/.codex/config.toml` or `.codex/config.toml`|trusted project loads `.codex/config.toml` from repo root to cwd|nearer directory overrides farther directory.
|Project Constraint:本仓以`.codex/config.toml`为项目配置|以`.agents/skills`为本地技能目录.
|Compression Format:首行必`# AGENTS.md`|余非空行皆以`|`起|宜用`Category:path:{...}`与`Category:value1|value2`.
|Allowed Content:结构|命令|约束|校验门禁|PR核对项.
|Forbidden Content:长篇铺叙|教程体|code fence|`##`|`###`.
|Anti Hallucination:毋得臆造路径/命令/规则/输出.
|Anti Hallucination:凡仓内无据者,标为`Unknown`,先请核可而后行.
|Anti Hallucination:关键路径与命令,先验后录.
|Evidence Priority:repo files > existing AGENTS.md > local skill references > user explicit input.
|Command Index:Validate=`python .agents/skills/agents-md-compress/scripts/example.py AGENTS.md`
|Fallback Validate:验标题|验IMPORTANT|验`|`前缀|验无`##`/`###`/code fence.
|Token Strategy:一行一规|并同类短规|删重辞|非请勿举冗例.
|Output Strategy:辞从简|但存可行事实|毋复述旧文.
|Change Workflow:撮要事实|改写索引|运行校验|修其不合.
|PR Checklist:变更范围|校验证据|风险记述.
|Maintenance Trigger:模块增改或路径易名|build/test命令变更|非空行逾35.
|Owner:维护者当随流程、结构、约束之变而更新此卷.
