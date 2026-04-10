<div align="center">

# TOKEN_COMPARISON

> `codex-tokens-compress` 五版本 `AGENTS` 规约量化对比报告（基线：`AGENTS.original.md`）。

![Baseline](https://img.shields.io/badge/Baseline-AGENTS.original.md-1677FF)
![Variants](https://img.shields.io/badge/Variants-5-52C41A)
![Metric](https://img.shields.io/badge/Metric-Token%20Saving-f66a39)

</div>

---

## 报告说明

本报告用于统一展示 5 个规约版本在结构规模与 token 成本上的差异，支持在“可读性、可维护性、token 成本”之间做版本选型。

最近同步到 `README.md`：`2026-04-10`

对比基线：

- `AGENTS.original.md`（原生散文版）

## 对比对象

1. `AGENTS.original.md`（原生散文版）
2. `AGENTS.md`（标准压缩版）
3. `AGENTS.compact.md`（极限压缩版）
4. `AGENTS.classical.md`（标准压缩版文言文）
5. `AGENTS.compact.classical.md`（极限压缩版文言文）

## 统计口径

- 行数：文件总行数（含空行）
- 文字数：UTF-8 文本字符总数（含换行）
- 估算Token：基于脚本的近似估算值（用于相对比较，不代表计费精确 token）
- Token节约占比：`(OriginalTokens - CurrentTokens) / OriginalTokens`

说明：

- 原始版 `AGENTS.original.md` 的 `Token节约占比` 固定为 `0.00%`。
- 节约占比越高，表示相对原始版压缩越充分。

## 数据快照（2026-04-10）

| File | 类型 | 行数 | 文字数 | 估算Token | 节约Token(对原始) | Token节约占比 |
| --- | :--- | ---: | ---: | ---: | ---: | ---: |
| `AGENTS.original.md` | 原生散文版 | 116 | 2269 | 1558 | 0 | 0.00% |
| `AGENTS.md` | 标准压缩版 | 27 | 2582 | 654 | 904 | 58.02% |
| `AGENTS.compact.md` | 极限压缩版 | 15 | 1190 | 309 | 1249 | 80.17% |
| `AGENTS.classical.md` | 标准压缩版文言文 | 27 | 1698 | 694 | 864 | 55.46% |
| `AGENTS.compact.classical.md` | 极限压缩版文言文 | 15 | 795 | 329 | 1229 | 78.88% |

## 结论摘要

1. `AGENTS.compact.md` 压缩收益最高：`80.17%`（节约 `1249` token）。
2. `AGENTS.compact.classical.md` 次高：`78.88%`（节约 `1229` token）。
3. `AGENTS.md` 与 `AGENTS.classical.md` 更偏向“压缩收益 + 可读性”平衡方案。

## 驱动因素

`Token节约占比` 主要受以下因素影响：

1. 是否删除叙述性段落，仅保留执行规则。
2. 规则是否索引化表达（单行单义、去重、短句）。
3. 语言与符号结构（中文/英文比例、分隔符密度）。
4. 重复语义是否被合并。

## 复跑命令

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\compare_agents_tokens.ps1
```

```bash
bash ./scripts/compare_agents_tokens.sh
```

建议每次修改任一 `AGENTS*.md` 后都重新执行并更新本报告快照。
