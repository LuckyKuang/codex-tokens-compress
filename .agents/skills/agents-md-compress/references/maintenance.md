# Maintenance Guide

## When to Re-compress

- 新增/重命名模块、目录结构变化。
- 构建或测试命令变化。
- 引入新质量门禁（lint/test/release）。
- AGENTS 行数明显膨胀，出现解释性段落回流。

## Warning Signals

- 出现多个 `##` 小节与长段落。
- 索引行与代码实际路径不一致。
- 同一规则在多行重复。

## Maintenance Flow

1. 备份当前 `AGENTS.md`。
2. 对照现有仓库结构核验路径。
3. 重新压缩为索引行。
4. 运行 `scripts/example.py` 校验。
5. 提交变更并在 PR 描述中说明影响范围。
