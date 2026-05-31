# Чеклист после переноса cursor-dotfiles

## На новой машине

- [ ] `git clone … ~/cursor-dotfiles`
- [ ] `./install.sh` (или `./install.sh --copy` если не хотите symlinks)
- [ ] Cursor → Settings → Rules → User Rules ← `user-rules/user-rules.md`
- [ ] Agent Chat → `/` → есть **git-commit**
- [ ] Тест в любом git-repo: `/git-commit` → branch + commit на English

## После `git pull` на старой машине

- [ ] `./install.sh` (symlink уже указывает на репо — достаточно pull)
- [ ] Если менялись User Rules — обновить в UI вручную

## Settings Sync (Cursor)

- [ ] Проверить, не конфликтуют ли synced User Rules с `user-rules.md`
- [ ] Skills **могут не sync'иться** — полагайтесь на `install.sh`

## Безопасность перед push в GitHub

- [ ] Нет `.env`, токенов, `config.local` в коммите
- [ ] `git status` чистый от секретов
- [ ] Репозиторий **private**, если есть hooks с внутренней логикой

## Опционально: связать live install с репо

Если сейчас skill в `~/.cursor/skills/git-commit` — **не копия**, а старая папка:

```bash
rm -rf ~/.cursor/skills/git-commit
cd ~/cursor-dotfiles && ./install.sh
```

Тогда правки только в git-репо.
