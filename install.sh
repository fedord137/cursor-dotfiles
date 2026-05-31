#!/usr/bin/env bash
# Install cursor-dotfiles into ~/.cursor (user scope, all projects).
# Usage: ./install.sh [--copy|--link]   (default: --link symlinks)

set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CURSOR_HOME="${CURSOR_HOME:-$HOME/.cursor}"
MODE="${1:---link}"

echo "==> cursor-dotfiles install"
echo "    Source: $DOTFILES_ROOT"
echo "    Target: $CURSOR_HOME"
echo "    Mode:   $MODE"
echo

mkdir -p "$CURSOR_HOME/skills"

install_skill() {
  local name="$1"
  local src="$DOTFILES_ROOT/skills/$name"
  local dst="$CURSOR_HOME/skills/$name"

  if [[ ! -d "$src" ]]; then
    echo "WARN: skill not found: $src" >&2
    return 1
  fi

  if [[ -e "$dst" || -L "$dst" ]]; then
    if [[ "$MODE" == "--link" ]] && [[ -L "$dst" ]] && [[ "$(readlink -f "$dst")" == "$(readlink -f "$src")" ]]; then
      echo "OK  skill $name (already linked)"
      return 0
    fi
    echo "    removing existing: $dst"
    rm -rf "$dst"
  fi

  if [[ "$MODE" == "--copy" ]]; then
    cp -a "$src" "$dst"
    echo "OK  skill $name (copied)"
  else
    ln -s "$src" "$dst"
    echo "OK  skill $name (symlinked)"
  fi
}

# Install each skill directory
for skill_dir in "$DOTFILES_ROOT"/skills/*/; do
  [[ -d "$skill_dir" ]] || continue
  install_skill "$(basename "$skill_dir")"
done

# Optional: hooks (when hooks/hooks.json exists)
if [[ -f "$DOTFILES_ROOT/hooks/hooks.json" ]]; then
  mkdir -p "$CURSOR_HOME/hooks"
  if [[ "$MODE" == "--copy" ]]; then
    cp -a "$DOTFILES_ROOT/hooks/." "$CURSOR_HOME/hooks/"
    cp "$DOTFILES_ROOT/hooks/hooks.json" "$CURSOR_HOME/hooks.json"
  else
    ln -sfn "$DOTFILES_ROOT/hooks" "$CURSOR_HOME/hooks-dotfiles"
    echo "NOTE: hooks bundled at $CURSOR_HOME/hooks-dotfiles"
    echo "      merge hooks/hooks.json into ~/.cursor/hooks.json manually or extend this script"
  fi
  echo "OK  hooks template present (see hooks/README.md)"
fi

echo
echo "==> Manual step required"
echo "    Paste user-rules/user-rules.md into:"
echo "    Cursor → Settings → Rules → User Rules"
echo
echo "==> Verify"
echo "    Open Agent Chat in any git repo → type / → look for 'git-commit'"
