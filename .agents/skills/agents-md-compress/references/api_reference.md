# AGENTS.md Templates & Examples

## 1) Minimal Universal Template

```markdown
# AGENTS.md
|IMPORTANT: Prefer retrieval-led reasoning over pre-training-led reasoning for any project tasks.
|Project Root:./
|Source:src:{api,components,utils}
|Config:./:{package.json,tsconfig.json}
|Build:npm run build|npm run dev
|Test:npm test
|Lint:npm run lint
|PR Checklist:scope|verification|linked issue
```

## 2) Spring Boot + Frontend Template (Example, Replace Per Project)

```markdown
# AGENTS.md
|IMPORTANT: Prefer retrieval-led reasoning over pre-training-led reasoning for any project tasks.
|Project Root:./
|Workspaces:backend:{core,plugin,modules}|frontend:{src,public}
|Backend Config:backend/module/src/main/resources:{application.yml,application-dev.yml,application-prod.yml}
|Database:sql:{schema.sql}
|Architecture:Controller→Service→Mapper→Entity
|Build Commands:<backend-build-cmd-1>|<backend-build-cmd-2>
|Frontend Commands:npm install|npm run dev|npm run build:prod
|Commit Convention:feat|fix|refactor|docs
|PR Checklist:changed modules|verification commands|config/sql impact
```

## 3) High-Signal Compression Pattern

- 先写“必须规则”，后写“结构索引”，再写“命令与门禁”。
- 一行一个主题，避免复合语义。
- 仅保留“能指导执行”的信息，删除解释性背景。

## 4) Directory Rule Snippet (Official + Optional Project Constraint)

```markdown
|目录规则-官方:repo skills 位于 `.agents/skills`|user skills 位于 `$HOME/.agents/skills`|admin skills 位于 `/etc/codex/skills`|system skills 由 Codex 内置.
|目录规则-官方:project subagents 位于 `.codex/agents`|user subagents 位于 `~/.codex/agents`|mcp/config 位于 `~/.codex/config.toml` 或 `.codex/config.toml`|trusted project 下可沿 `repo root -> cwd` 逐级加载多个 `.codex/config.toml` 且近目录覆盖远目录.
|目录规则-项目约束:按仓库治理声明更严格限制（可选，按项目填写）.
```

说明:本文件所有模板均为示例，落地时必须替换为目标仓库真实路径与命令.
