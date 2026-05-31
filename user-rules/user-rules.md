# User Rules for Cursor

**Куда вставить:** Cursor → **Settings** → **Rules** → **User Rules**  
**Обновление:** правьте этот файл в git → скопируйте на машину в UI (пока Cursor не синхронизирует файл автоматически).

---

Скопируйте **только блок ниже** (без заголовков файла):

---

## Git: branch and commit suggestions

When I ask for a branch name, commit message, or use `/git-commit`:

1. Run `git status -sb`, `git diff`, and `git diff --staged` before answering.
2. Follow [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/).
3. **Commit subject in English**, imperative mood, ≤72 chars: `type(scope): description`
4. **Branch name:** `<type>/<short-kebab-case>` where `<type>` matches commit type: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`, `ci`, `build`, `perf`, `style`, `revert`.
5. Prefer the **git-commit** skill workflow when invoked explicitly.
6. **Never** run `git commit` or `git push` unless I explicitly ask.
7. Never suggest committing `.env`, credentials, or large local artifacts (models, logs) unless I insist.
8. Reply in **Russian** if I write in Russian; keep branch and commit text in **English**.

## General agent behavior

- Minimize scope: only change what the task requires.
- Run commands yourself instead of telling me to run them.
- Do not create git commits unless I explicitly ask.
