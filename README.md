# cursor-dotfiles

Переносимый набор **ваших** настроек Cursor IDE: skills, snippets правил, скрипт установки.

> **Не путать с** `~/.cursor/skills-cursor/` — это встроенные skills Cursor, их **не** кладите сюда.

---

## Нормальная ли это идея?

**Да**, если соблюдать границы:

| Плюс | Минус / риск |
|------|----------------|
| Один git-репо → все ноутбуки одинаковые | User Rules из UI **не** лежат в файле автоматически — храните копию в `user-rules/` |
| История изменений skill'ов и hooks | **Не коммитьте** секреты (`.env`, токены, `config.local`) |
| Быстрый onboarding на новой машине | Settings Sync Cursor может частично дублировать — проверяйте, что skill реально подхватился |
| Можно шарить с командой (ветка/форк) | Cloud Agent не видит `~/.cursor/skills/` — только project-level `.cursor/` в репо |

**Вывод:** dotfiles-репо для Cursor — стандартная практика (как `.vim`, `.config`). Держите здесь **только то, что вы авторствовали**.

---

## Структура

```text
cursor-dotfiles/
├── README.md                 # этот файл
├── install.sh                # установка в ~/.cursor
├── .gitignore
├── user-rules/
│   └── user-rules.md         # вставить в Settings → Rules → User Rules
├── skills/
│   └── git-commit/           # /git-commit в Agent Chat
│       ├── SKILL.md
│       ├── reference.md
│       ├── README.md
│       ├── PORTABLE_SETUP.md
│       └── USER_RULES_SNIPPET.md
├── hooks/                    # заготовка под ~/.cursor/hooks.json
│   └── README.md
└── docs/
    └── sync-checklist.md     # чеклист после переноса
```

---

## Установка (новая машина)

```bash
git clone <your-repo-url> ~/cursor-dotfiles
cd ~/cursor-dotfiles
chmod +x install.sh
./install.sh
```

Затем:

1. **Cursor → Settings → Rules → User Rules** — скопировать содержимое `user-rules/user-rules.md` (блок после `---`).
2. Agent Chat → `/` — проверить, что есть **git-commit**.

---

## Обновление skill на другой машине

```bash
cd ~/cursor-dotfiles && git pull && ./install.sh
```

---

## Что сюда добавлять по мере роста

- [ ] новые skills в `skills/<name>/`
- [ ] `hooks/hooks.json` + скрипты (если появятся)
- [ ] legacy commands в `commands/*.md` (или мигрировать в skills через `/migrate-to-skills`)
- [ ] project-шаблон `.cursor/rules/` — опционально в `templates/project-rules/`

---

## Что сюда **не** кладите

- `~/.cursor/skills-cursor/` — internal Cursor
- `~/.cursor/projects/` — кэш IDE
- `.env`, API keys, `.dvc/config.local`
- `ide_state.json`, логи

---

## Связанные ссылки

- [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/)
- [Cursor Rules docs](https://cursor.com/docs/rules)
