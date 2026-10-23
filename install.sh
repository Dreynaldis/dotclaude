#!/usr/bin/env bash
# install.sh — run once after cloning dotclaude on a new machine
#
# macOS / Linux: ln -s works for files and dirs, no special permissions needed.
# Windows (Git Bash): uses cmd /c mklink for files, mklink /j for dirs.
#   Requires Developer Mode ON (Settings → System → Developer Mode).
#   PowerShell New-Item -ItemType SymbolicLink needs admin even with Dev Mode —
#   cmd /c mklink does not.
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
CLAUDE="$HOME/.claude"

mkdir -p "$CLAUDE"

echo "Dotclaude repo: $REPO"
echo "Claude config:  $CLAUDE"
echo ""

# Back up anything that already exists and isn't already a symlink/junction
for target in CLAUDE.md settings.json statusline-command.sh skills agents knowledge; do
  path="$CLAUDE/$target"
  if [ -e "$path" ] && [ ! -L "$path" ]; then
    mv "$path" "${path}.bak"
    echo "Backed up: $path → ${path}.bak"
  fi
done

# Detect OS
OS="$(uname -s)"
case "$OS" in
  Linux|Darwin)
    # ── macOS / Linux ─────────────────────────────────────────────────────────
    ln -sfn "$REPO/CLAUDE.md"             "$CLAUDE/CLAUDE.md"
    ln -sfn "$REPO/settings.json"         "$CLAUDE/settings.json"
    ln -sfn "$REPO/statusline-command.sh" "$CLAUDE/statusline-command.sh"
    ln -sfn "$REPO/skills"                "$CLAUDE/skills"
    ln -sfn "$REPO/agents"                "$CLAUDE/agents"
    ln -sfn "$REPO/knowledge"             "$CLAUDE/knowledge"
    echo "Symlinks created (ln -s)."
    ;;

  MINGW*|MSYS*|CYGWIN*)
    # ── Windows (Git Bash) ────────────────────────────────────────────────────
    # Directories: junctions — no Dev Mode needed
    for dir in skills agents knowledge; do
      if [ ! -e "$CLAUDE/$dir" ]; then
        cmd //c mklink //j "$(cygpath -w "$CLAUDE/$dir")" "$(cygpath -w "$REPO/$dir")" > /dev/null
        echo "Junction:  $CLAUDE/$dir"
      else
        echo "Skipped (exists): $CLAUDE/$dir"
      fi
    done

    # Files: symlinks — need Developer Mode ON. Already-linked files are
    # skipped, so re-running never falls through to copying a file onto itself.
    COPIED=false
    for file in CLAUDE.md settings.json statusline-command.sh; do
      if [ -L "$CLAUDE/$file" ]; then
        echo "Skipped (linked): $CLAUDE/$file"
      elif cmd //c mklink "$(cygpath -w "$CLAUDE/$file")" "$(cygpath -w "$REPO/$file")" > /dev/null 2>&1; then
        echo "Symlink:   $CLAUDE/$file"
      else
        cp "$REPO/$file" "$CLAUDE/$file"
        echo "Copied:    $CLAUDE/$file"
        COPIED=true
      fi
    done

    if [ "$COPIED" = true ]; then
      echo ""
      echo "WARNING: File symlinks failed — Developer Mode is OFF."
      echo "  Copied files will NOT sync back to the repo automatically."
      echo "  To fix: Settings → System → Developer Mode → ON, delete the copies,"
      echo "  then re-run: bash install.sh"
    fi
    ;;

  *)
    echo "Unknown OS: $OS — please create symlinks manually:"
    echo "  ln -s $REPO/CLAUDE.md             $CLAUDE/CLAUDE.md"
    echo "  ln -s $REPO/settings.json         $CLAUDE/settings.json"
    echo "  ln -s $REPO/statusline-command.sh $CLAUDE/statusline-command.sh"
    echo "  ln -s $REPO/skills                $CLAUDE/skills"
    echo "  ln -s $REPO/agents                $CLAUDE/agents"
    echo "  ln -s $REPO/knowledge             $CLAUDE/knowledge"
    exit 1
    ;;
esac

# ── Shell alias ───────────────────────────────────────────────────────────────
# Detect rc file: .zshrc on macOS/zsh. For bash, ~/.bashrc is a stub that
# dotfiles/install.sh rewrites, so machine-specific lines like this alias (the
# repo path differs per machine) go in ~/.bashrc.local, which the shared
# dotfiles bashrc sources.
if [ "$OS" = "Darwin" ] || [ "${SHELL:-}" = "/bin/zsh" ] || [ "${SHELL:-}" = "/usr/bin/zsh" ]; then
  SHELL_RC="$HOME/.zshrc"
else
  SHELL_RC="$HOME/.bashrc.local"
fi

ALIAS_LINE="alias dotclaude='cd \"$REPO\"'"

if grep -qF "alias dotclaude=" "$SHELL_RC" 2>/dev/null; then
  echo "Alias 'dotclaude' already in $SHELL_RC — skipped."
else
  printf '\n# dotclaude — jump to claude config repo\n%s\n' "$ALIAS_LINE" >> "$SHELL_RC"
  echo "Added alias 'dotclaude' to $SHELL_RC"
  echo "  Run: source $SHELL_RC  (or open a new terminal)"
fi

echo ""
echo "Done. Claude config is live."
