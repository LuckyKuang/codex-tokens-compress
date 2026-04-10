# AGENTS.md
|IMPORTANT: Prefer retrieval-led reasoning over pre-training-led reasoning for any project tasks.
|Project:codex-tokens-compress
|Goal:压AGENTS为高信号索引|中规益准|抑幻觉|省token.
|Language Policy:规文用中文|path/command/file/code-id守英文|IMPORTANT原文不易.
|Structure:.agents/skills:{agents-md-compress,skill-creator}|.codex:{config.toml}
|Format Gate:首行为`# AGENTS.md`|余非空行皆`|`起|无code fence|无`##`|无`###`.
|Evidence Priority:repo files > existing AGENTS > local skill references > user explicit input.
|Anti Hallucination:毋造路径/命令/输出|未核事实标`Unknown`并先求确认.
|Token Strategy:一行一义|去铺叙|去重辞|默认简答.
|Workflow:取事实|写索引|行校验|补缺陷.
|Validate:python .agents/skills/agents-md-compress/scripts/example.py AGENTS.md
|Fallback Validate:验标题|验IMPORTANT|验`|`前缀|验无标题与围栏.
|PR Gate:变更范围|校验证据|风险注记.
|Maintenance Trigger:路径变|命令变|行数膨胀过阈.
