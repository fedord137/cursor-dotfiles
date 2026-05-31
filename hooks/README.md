# Hooks (заготовка)

User-level hooks: `~/.cursor/hooks.json` + скрипты в `~/.cursor/hooks/`.

## Когда добавлять

- Блокировать `git commit` без Conventional Commits
- Запрещать `git push --force` на main
- Форматировать файлы после `afterFileEdit`

## Как добавить в этот репозиторий

1. Положите скрипты сюда: `hooks/scripts/my-hook.sh`
2. Положите манифест: `hooks/hooks.json`
3. Расширьте `install.sh` для копирования/слияния с `~/.cursor/hooks.json`

Документация: Cursor → create-hook skill / https://cursor.com/docs

## Пример hooks.json (шаблон)

```json
{
  "version": 1,
  "hooks": {
    "beforeShellExecution": [
      {
        "command": "./hooks/scripts/validate-git-commit.sh",
        "matcher": "git commit"
      }
    ]
  }
}
```

**Примечание:** user hooks работают в **локальном** Agent, не в Cloud Agents.
