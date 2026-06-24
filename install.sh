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
for target in CLAUDE.md settings.json statusline-command.sh skills agents; do
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
    ln -sf "$REPO/CLAUDE.md"             "$CLAUDE/CLAUDE.md"
    ln -sf "$REPO/settings.json"         "$CLAUDE/settings.json"
    ln -sf "$REPO/statusline-command.sh" "$CLAUDE/statusline-command.sh"
    ln -sf "$REPO/skills"                "$CLAUDE/skills"
    ln -sf "$REPO/agents"                "$CLAUDE/agents"
    echo "Symlinks created (ln -s)."
    ;;

  MINGW*|MSYS*|CYGWIN*)
    # ── Windows (Git Bash) ────────────────────────────────────────────────────
    # Directories: junctions — no Dev Mode needed
    for dir in skills agents; do
      if [ ! -e "$CLAUDE/$dir" ]; then
        cmd //c mklink //j "$(cygpath -w "$CLAUDE/$dir")" "$(cygpath -w "$REPO/$dir")" > /dev/null
        echo "Junction:  $CLAUDE/$dir"
      else
        echo "Skipped (exists): $CLAUDE/$dir"
      fi
    done

    # Files: symlinks — need Developer Mode ON
    DEVMODE_OK=false
    if cmd //c mklink "$(cygpath -w "$CLAUDE/CLAUDE.md")" "$(cygpath -w "$REPO/CLAUDE.md")" > /dev/null 2>&1; then
      DEVMODE_OK=true
      cmd //c mklink "$(cygpath -w "$CLAUDE/settings.json")"         "$(cygpath -w "$REPO/settings.json")"         > /dev/null
      cmd //c mklink "$(cygpath -w "$CLAUDE/statusline-command.sh")" "$(cygpath -w "$REPO/statusline-command.sh")" > /dev/null
      echo "Symlinks:  CLAUDE.md, settings.json, statusline-command.sh"
    else
      cp "$REPO/CLAUDE.md"             "$CLAUDE/CLAUDE.md"
      cp "$REPO/settings.json"         "$CLAUDE/settings.json"
      cp "$REPO/statusline-command.sh" "$CLAUDE/statusline-command.sh"
      echo ""
      echo "WARNING: File symlinks failed — Developer Mode is OFF."
      echo "  Files were COPIED instead. Edits to ~/.claude/CLAUDE.md etc."
      echo "  will NOT sync back to the repo automatically."
      echo ""
      echo "  To fix: Settings → System → Developer Mode → ON"
      echo "  Then re-run: bash install.sh"
    fi
    ;;

  *)
    echo "Unknown OS: $OS — please create symlinks manually:"
    echo "  ln -s $REPO/CLAUDE.md             $CLAUDE/CLAUDE.md"
    echo "  ln -s $REPO/settings.json         $CLAUDE/settings.json"
    echo "  ln -s $REPO/statusline-command.sh $CLAUDE/statusline-command.sh"
    echo "  ln -s $REPO/skills                $CLAUDE/skills"
    echo "  ln -s $REPO/agents                $CLAUDE/agents"
    exit 1
    ;;
esac

echo ""
echo "Done. Claude config is live."
