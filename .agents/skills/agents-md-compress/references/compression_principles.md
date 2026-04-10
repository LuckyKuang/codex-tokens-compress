# Compression Principles

## Why This Works

- 被动上下文优于临时检索：规则每轮都可见，不依赖 agent 选择是否查找。
- 索引结构优于散文叙述：减少歧义，提升解析速度。
- 单行约束可组合：便于增删、diff、自动校验。

## Canonical Line Grammar

- 所有索引行以 `|` 开头。
- 常用模式：
  - `|Category:path:{item1,item2,item3}`
  - `|Category:value1|value2|value3`

## Symbol Semantics

- `|`：索引行起始与多值分隔。
- `:`：类别与内容分隔。
- `{}`：同类多项集合。
- `→`：流程或分层关系（如 `Controller→Service→Mapper→Entity`）。

## Compression Boundaries

保留：
- 目录结构、入口文件、配置路径、命令、命名规范、PR门禁。

删除：
- 解释性段落、背景故事、重复示例、完整教程式内容。
