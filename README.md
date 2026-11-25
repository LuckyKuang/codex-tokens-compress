<div align="center">

# codex-tokens-compress

<!-- yarkr:badges:start -->
[![Indexed on Yarkr](https://api.yarkr.com/functions/v1/api/api/v1/badges/repos/LuckyKuang/codex-tokens-compress/version.svg)](https://yarkr.com/arks/luckykuang/codex-tokens-compress)
<!-- yarkr:badges:end -->

> 面向 AI 协作场景的 `AGENTS.md` 压缩实验仓库：用统一规约格式提升指令命中率、降低幻觉风险，并量化 token 压缩收益。

![Variants](https://img.shields.io/badge/AGENTS%20Variants-5-1677FF)
![Language](https://img.shields.io/badge/Language-中文-52C41A)
![Token Compare](https://img.shields.io/badge/Token%20Compare-Ready-f66a39)
![Linux](https://img.shields.io/badge/Linux-do-42B883)
![License](https://img.shields.io/badge/License-MIT-F7C948)

</div>

---

## 项目简介

`codex-tokens-compress` 聚焦一件事：把冗长、叙述性的 `AGENTS.md` 规约压缩为高密度、可执行、可校验的规则文档，并通过统一脚本对不同写法进行量化比对。

项目目标：

1. 提升 AI 执行任务时的规则命中率。
2. 降低“无证据推断”带来的幻觉风险。
3. 在可维护前提下尽可能降低 token 消耗。

## 项目定位

本项目面向三个核心场景：

1. **规约工程化**：把 `AGENTS.md` 从“说明文”转成“可验证规则集”。
2. **压缩策略实验**：同时维护原始版、标准压缩版、极限压缩版与文言文变体。
3. **量化决策支持**：用统一脚本输出 token 节约占比，支持版本选型。

## 仓库结构

```text
codex-tokens-compress
├── AGENTS.original.md                 # 原始散文版基线
├── AGENTS.md                          # 标准压缩版
├── AGENTS.compact.md                  # 极限压缩版
├── AGENTS.classical.md                # 标准压缩版（文言文）
├── AGENTS.compact.classical.md        # 极限压缩版（文言文）
├── TOKEN_COMPARISON.md                # 五版本对比快照与方法说明
├── scripts
│   ├── compare_agents_tokens.ps1      # token 对比脚本（Windows PowerShell）
│   └── compare_agents_tokens.sh       # token 对比脚本（Linux/macOS Bash）
├── .agents
│   └── skills
│       ├── agents-md-compress         # 压缩技能、参考与校验脚本
│       └── skill-creator              # skill 构建与评估工具链
├── .codex
│   └── config.toml                    # 项目级 Codex / MCP 配置
└── LICENSE
```

## 技术与方法

| 维度 | 内容 |
| --- | --- |
| 规约模型 | 原始版、标准压缩版、极限压缩版、文言文变体 |
| 压缩格式 | `# AGENTS.md` + 索引行（`|` 前缀） |
| 校验方式 | `agents-md-compress/scripts/example.py` + 静态兜底校验 |
| 对比脚本 | `scripts/compare_agents_tokens.ps1` / `scripts/compare_agents_tokens.sh` |
| 指标体系 | 行数、文字数、Token节约占比 |

## 核心资产

### 1) AGENTS 五版本

- [`AGENTS.original.md`](./AGENTS.original.md)：原始散文版，信息完整，token 成本最高。
- [`AGENTS.md`](./AGENTS.md)：标准压缩版，信息密度与可维护性平衡。
- [`AGENTS.compact.md`](./AGENTS.compact.md)：极限压缩版，最小化 token 开销。
- [`AGENTS.classical.md`](./AGENTS.classical.md)：标准压缩版文言文表达。
- [`AGENTS.compact.classical.md`](./AGENTS.compact.classical.md)：极限压缩版文言文表达。

### 2) 对比与报告

- [`scripts/compare_agents_tokens.ps1`](./scripts/compare_agents_tokens.ps1)：Windows PowerShell 一键输出估算 token 对比。
- [`scripts/compare_agents_tokens.sh`](./scripts/compare_agents_tokens.sh)：Linux/macOS Bash 一键输出估算 token 对比。
- [`TOKEN_COMPARISON.md`](./TOKEN_COMPARISON.md)：固定快照与方法说明。

### 3) 压缩技能与参考

- [`agents-md-compress/SKILL.md`](./.agents/skills/agents-md-compress/SKILL.md)
- [`api_reference.md`](./.agents/skills/agents-md-compress/references/api_reference.md)
- [`compression_principles.md`](./.agents/skills/agents-md-compress/references/compression_principles.md)
- [`checklists_and_antipatterns.md`](./.agents/skills/agents-md-compress/references/checklists_and_antipatterns.md)
- [`maintenance.md`](./.agents/skills/agents-md-compress/references/maintenance.md)

## 环境要求

| 组件 | 建议 |
| --- | --- |
| PowerShell | 5.1+ 或 PowerShell 7+ |
| Bash | 4.0+（Linux/macOS） |
| Python | 可选（用于运行 `example.py`） |
| 编码 | UTF-8 |

说明：若本机无法直接调用 `python.exe`，可使用静态校验流程作为兜底。

## 快速开始

### 1) 查看五版本差异

先阅读：

- [`AGENTS.original.md`](./AGENTS.original.md)
- [`AGENTS.md`](./AGENTS.md)
- [`AGENTS.compact.md`](./AGENTS.compact.md)
- [`AGENTS.classical.md`](./AGENTS.classical.md)
- [`AGENTS.compact.classical.md`](./AGENTS.compact.classical.md)

### 2) 运行 token 对比

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\compare_agents_tokens.ps1
```

```bash
bash ./scripts/compare_agents_tokens.sh
```

### 3) 校验压缩格式（可选）

```bash
python .agents/skills/agents-md-compress/scripts/example.py AGENTS.md
```

## 常用命令

```powershell
# 运行五版本 token 对比
powershell -ExecutionPolicy Bypass -File .\scripts\compare_agents_tokens.ps1

# 查看当前 AGENTS 文件
Get-ChildItem AGENTS*.md | Select-Object Name,Length

# 查看对比快照文档
Get-Content -Raw -Encoding UTF8 .\TOKEN_COMPARISON.md
```

```bash
# 运行五版本 token 对比
bash ./scripts/compare_agents_tokens.sh

# 查看当前 AGENTS 文件
ls AGENTS*.md

# 查看对比快照文档
cat ./TOKEN_COMPARISON.md
```

## 五版本量化对比

本节用于统一展示 5 个规约版本在结构规模与 token 成本上的差异，支持在“可读性、可维护性、token 成本”之间做版本选型。

统计基线：`AGENTS.original.md`

快照来源：[`TOKEN_COMPARISON.md`](./TOKEN_COMPARISON.md)  
报告快照更新时间：`2026-04-10`

对比对象：

1. `AGENTS.original.md`（原生散文版）
2. `AGENTS.md`（标准压缩版）
3. `AGENTS.compact.md`（极限压缩版）
4. `AGENTS.classical.md`（标准压缩版文言文）
5. `AGENTS.compact.classical.md`（极限压缩版文言文）

统计口径：

- 行数：文件总行数（含空行）
- 文字数：UTF-8 文本字符总数（含换行）
- Token节约占比：`(OriginalTokens - CurrentTokens) / OriginalTokens`

2026-04-10 快照：

| File | 行数 | 文字数 | 估算Token | Token节约占比 |
| --- | ---: | ---: | ---: | ---: |
| `AGENTS.original.md` | 116 | 2269 | 1558 | 0.00% |
| `AGENTS.md` | 27 | 2582 | 654 | 58.02% |
| `AGENTS.compact.md` | 15 | 1190 | 309 | 80.17% |
| `AGENTS.classical.md` | 27 | 1698 | 694 | 55.46% |
| `AGENTS.compact.classical.md` | 15 | 795 | 329 | 78.88% |

结论（相对 `AGENTS.original.md`）：

1. `AGENTS.compact.md` 压缩收益最高（`80.17%`）。
2. `AGENTS.compact.classical.md` 次高（`78.88%`）。
3. `AGENTS.md` 与 `AGENTS.classical.md` 更偏向可读性与平衡策略。

### 快照更新流程

1. 运行对比脚本（任选其一）：`powershell -ExecutionPolicy Bypass -File .\scripts\compare_agents_tokens.ps1` 或 `bash ./scripts/compare_agents_tokens.sh`
2. 将最新统计结果同步更新到 [`TOKEN_COMPARISON.md`](./TOKEN_COMPARISON.md)
3. 回写本节“报告快照更新时间”与对比表

## 版本选型建议

1. 追求最低 token 成本：优先 `AGENTS.compact.md`。
2. 追求可维护与可读平衡：优先 `AGENTS.md`。
3. 需要文风统一（文言文）：在 `AGENTS.classical.md` 与 `AGENTS.compact.classical.md` 之间按成本选择。

## 文档导航

- 规则基线：[`AGENTS.original.md`](./AGENTS.original.md)
- 压缩规则：[`AGENTS.md`](./AGENTS.md)、[`AGENTS.compact.md`](./AGENTS.compact.md)
- 文言文规则：[`AGENTS.classical.md`](./AGENTS.classical.md)、[`AGENTS.compact.classical.md`](./AGENTS.compact.classical.md)
- 对比报告：[`TOKEN_COMPARISON.md`](./TOKEN_COMPARISON.md)
- 项目协议：[`LICENSE`](./LICENSE)

<!-- yarkr:install:start -->
## Install with Yarkr

This repo is indexed on [Yarkr](https://yarkr.com/arks/luckykuang/codex-tokens-compress) as the ark [luckykuang/codex-tokens-compress](https://yarkr.com/arks/luckykuang/codex-tokens-compress), so its skills install into Claude Code, Codex, Cursor and other agent harnesses with one command.

### CLI

Install the whole ark, which Yarkr keeps equal to this repo:

```bash
npx yarkr-cli sync luckykuang/codex-tokens-compress
```

Or add individual skills:

```bash
npx yarkr-cli add skill:luckykuang/codex-tokens-compress/agents-md-compress
npx yarkr-cli add skill:luckykuang/codex-tokens-compress/skill-creator
```

No Node.js? `curl -fsSL https://yarkr.com/install.sh | sh` (macOS, Linux) or `irm https://yarkr.com/install.ps1 | iex` (Windows PowerShell) installs `yarkr` as a standalone binary; then type `yarkr` in place of `npx yarkr-cli`.

### MCP

Connect your agent to the ark over MCP:

```bash
npx yarkr-cli mcp add luckykuang/codex-tokens-compress
```

Or point any MCP client at `https://api.yarkr.com/functions/v1/api/mcp/o/luckykuang/codex-tokens-compress`.
<!-- yarkr:install:end -->

## License

[MIT License](./LICENSE)
