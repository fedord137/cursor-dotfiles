# Перенос git-commit skill на другой ноутбук (рабочий ПК)

Skill и User Rules живут **локально** в профиле Cursor, не в git-репозитории проекта.  
Чтобы не настраивать заново — используйте репозиторий **`~/cursor-dotfiles`**.

---

## Что переносить

| Артефакт | Путь на Linux/macOS | В git? |
|----------|---------------------|--------|
| **Skill (главное)** | `~/cursor-dotfiles/skills/git-commit/` | ✅ этот репо |
| **User Rules** | Cursor Settings (UI) | копия в `user-rules/user-rules.md` |
| **Hooks** (если добавите) | `~/cursor-dotfiles/hooks/` | ✅ |

**Не переносить:** `~/.cursor/skills-cursor/` — встроенные skills Cursor.

---

## Способ 1 — Dotfiles-репозиторий (рекомендуется)

1. Создайте репозиторий, например `github.com/you/cursor-dotfiles`.
2. Клонируйте на новую машину:

   ```bash
   git clone git@github.com:YOU/cursor-dotfiles.git ~/cursor-dotfiles
   ```

3. Установите:

   ```bash
   cd ~/cursor-dotfiles
   chmod +x install.sh
   ./install.sh
   ```

4. Вставьте `user-rules/user-rules.md` в **Cursor → Settings → Rules → User Rules**.

---

## Способ 2 — Архив / облако (быстро, без git)

```bash
# упаковать
tar -czvf cursor-dotfiles.tgz -C ~ cursor-dotfiles

# на новой машине
mkdir -p ~/.cursor/skills
tar -xzvf cursor-dotfiles.tgz -C ~
cd ~/cursor-dotfiles && ./install.sh
```

Затем вручную вставить текст из `user-rules/user-rules.md` в User Rules.

---

## Способ 3 — Синхронизация профиля Cursor

Если используете **Settings Sync** в Cursor:

- User Rules часто синхронизируются с аккаунтом Cursor.
- **Skills в `~/.cursor/skills/`** могут **не** синхронизироваться автоматически — проверьте на второй машине наличие `/git-commit`.

После sync на новом ПК:

1. Откройте Agent Chat → введите `/` → должен появиться **git-commit**.
2. Если нет — используйте Способ 1 или 2.

---

## Способ 4 — Team / plugin (для команды)

Для org-wide стандарта:

- **Team Rules** в dashboard Cursor (Team/Enterprise).
- Или **Cursor Plugin** с bundled skill в `~/.cursor/plugins/local/`.

---

## Чеклист после переноса

- [ ] `~/.cursor/skills/git-commit` → symlink на `~/cursor-dotfiles/skills/git-commit`
- [ ] В чате Agent команда `/git-commit` доступна
- [ ] User Rules вставлены (Settings → Rules)
- [ ] Тест: открыть любой git-repo → `/git-commit` → branch + commit на English

---

## Обновление skill

При правках на одной машине:

```bash
cd ~/cursor-dotfiles
git add -A && git commit -m "chore(cursor): update git-commit skill" && git push
```

На другой машине:

```bash
cd ~/cursor-dotfiles && git pull
# symlink уже указывает на репо — install.sh не обязателен
```

См. также: `../../docs/sync-checklist.md`

---

## Связать live install с репо (если skill был копией, не symlink)

```bash
rm -rf ~/.cursor/skills/git-commit
cd ~/cursor-dotfiles && ./install.sh
```

Тогда правки только в git-репо, Agent сразу видит обновления.
