---
name: git-commit
description: >-
  Analyzes git status and diff, then suggests a branch name and a short
  Conventional Commits message (English). Branch prefix MUST match commit type
  (feat/, fix/, chore/, …). Use when the user invokes /git-commit, asks for
  branch name, commit message, or conventional commit suggestion.
disable-model-invocation: true
---

# Git branch + Conventional Commit message

Skill for **any** git repository open in Cursor. Spec: [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/).

**Language:** commit **subject** and branch slug in **English** (imperative, lowercase slug).  
Reply to the user may be **Russian** if they write in Russian.

---

## When this skill runs

- User typed `/git-commit` or asked: «ветка», «commit message», «conventional commit», «название ветки».
- **Do not** run `git commit`, `git push`, or create branches unless the user **explicitly** asks to commit/push/checkout.

---

## Step 1 — Inspect the repository (required)

Run **in parallel** from the workspace root:

```bash
git status -sb
git diff
git diff --staged
git branch --show-current
git log -3 --oneline
```

**Why each command:**

| Command | Purpose |
|---------|---------|
| `status -sb` | Short status: branch, ahead/behind, changed/untracked files |
| `diff` | Unstaged changes — main source for message |
| `diff --staged` | Staged changes — if user already `git add` |
| `branch --show-current` | Warn if committing on `main`/`master` without a feature branch |
| `log -3` | Match repo tone and scope naming |

**If not a git repo:** say so and stop.  
**If no changes:** say «nothing to commit» and skip branch/message.  
**If only untracked junk** (logs, `.pkl`, `catboost_info/`): mention `.gitignore`, do not suggest adding secrets (`.env`).

---

## Step 2 — Classify the change → commit `<type>`

Pick **one primary type** per [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).  
If changes mix types → suggest **splitting commits** (spec FAQ).

| Type | When to use | SemVer hint |
|------|-------------|-------------|
| **feat** | New feature, new capability for the user | MINOR |
| **fix** | Bug fix | PATCH |
| **docs** | Documentation only | — |
| **style** | Formatting, whitespace; **no** logic change | — |
| **refactor** | Code change without fix or feature | — |
| **perf** | Performance improvement | — |
| **test** | Adding or fixing tests | — |
| **build** | Build system, dependencies (`pyproject`, `Dockerfile`) | — |
| **ci** | CI/CD configs | — |
| **chore** | Maintenance, tooling, misc; no src/test change | — |
| **revert** | Reverts a prior commit | — |

**Breaking change:** append `!` after type/scope (`feat(api)!:`) or footer `BREAKING CHANGE:` — only if diff clearly breaks API/behavior.

---

## Step 3 — Choose optional `<scope>`

Scope = **noun**, area of codebase in parentheses: `feat(dvc): …`

**How to pick scope:**

1. Top-level folder touched most: `airflow`, `dvc`, `etl`, `docker`, `deps`
2. Or module name: `fit`, `evaluate`, `hooks`
3. Omit scope if change is repo-wide or unclear

**Examples from ML/data projects:**

- `feat(dvc): add fit and evaluate scripts`
- `fix(etl): filter orphan building rows in transform`
- `chore(docker): mount dags from part1_airflow`

---

## Step 4 — Branch name (must align with commit type)

**Format:**

```text
<type>/<short-kebab-description>
```

**Rules:**

- `<type>` — **same** as commit type (`feat`, `fix`, `chore`, …) — not `feature/` or `bugfix/`
- `<short-kebab-description>` — English, lowercase, hyphens, no spaces
- Max ~50 characters total; drop filler words (`add`, `update`) if too long
- No ticket required; optional: `feat/JIRA-123-short-desc`

**Examples:**

| Change | Branch | Commit subject |
|--------|--------|----------------|
| New DVC stage | `feat/dvc-evaluate-stage` | `feat(dvc): add evaluate_model stage` |
| Fix S3 key | `fix/airflow-s3-run-id` | `fix(etl): sanitize run_id in S3 keys` |
| README only | `docs/project-review` | `docs: add sprint1 review guide` |
| Bump lockfile | `chore/uv-lock-update` | `chore(deps): refresh uv.lock` |

**If already on a matching branch:** say «current branch OK» instead of inventing a new one.

**If on `main`/`master` with real changes:** recommend creating the suggested branch before commit.

---

## Step 5 — Commit message (short)

**Structure** ([spec](https://www.conventionalcommits.org/en/v1.0.0/)):

```text
<type>[optional scope]: <description>
```

**Rules for `<description>` (subject line):**

- **Imperative mood** — «add», «fix», «remove» (not «added», «fixes»)
- **Lowercase** start (common convention; spec allows any case but stay consistent)
- **No period** at the end
- **≤ 72 characters** for the subject line
- **One line only** unless user asks for a body

**Optional body** (only if user asks «подробный коммит»):

```text
feat(dvc): add cross-validation metrics export

Run 5-fold CV on train split and write avg_r2 and avg_mae to cv_res.json.
```

**Do not commit** `.env`, credentials, large binaries, or local runtime artifacts unless user insists.

---

## Step 6 — Output format (always use this)

```markdown
## Branch
`type/short-description`
(or: текущая ветка подходит — `feat/...`)

## Commit
`type(scope): imperative description`

## Type rationale
One sentence: why this type and scope.

## Notes (optional)
- Split commits? / .gitignore / don't commit files X
```

Keep **Notes** brief.

---

## Quick examples

**User changed only `PROJECT_REVIEW.md`:**

- Branch: `docs/project-review-glossary`
- Commit: `docs: add ML glossary to project review`

**User changed `fit.py` hyperparameters handling:**

- Branch: `refactor/dvc-fit-params`
- Commit: `refactor(dvc): load CatBoost params from params.yaml`

**User fixed cleaning DAG reading wrong table:**

- Branch: `fix/clean-dataset-table-name`
- Commit: `fix(etl): read flats_dataset in clean DAG`

---

## Related files in cursor-dotfiles repo

- `reference.md` — full type table + breaking changes + FAQ
- `../../user-rules/user-rules.md` — paste into Cursor **Settings → Rules → User Rules**
- `../../docs/sync-checklist.md` — verify after install on a new machine
