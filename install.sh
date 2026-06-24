#!/usr/bin/env bash
# install.sh — run once after cloning dotclaude on a new machine
# Requires Windows Developer Mode ON for file symlinks (Settings → System → Developer Mode)
# Directory junctions work without it.
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

# --- Directories: use junctions (no admin / Dev Mode needed on Windows) ---
for dir in skills agents; do
  if [ ! -e "$CLAUDE/$dir" ]; then
    cmd.exe //c mklink //j "$(cygpath -w "$CLAUDE/$dir")" "$(cygpath -w "$REPO/$dir")" > /dev/null
    echo "Junction:  $CLAUDE/$dir → $REPO/$dir"
  else
    echo "Skipped (exists): $CLAUDE/$dir"
  fi
done

# --- Files: symlinks require Developer Mode ---
DEVMODE_OK=false
if cmd.exe //c mklink "$(cygpath -w "$CLAUDE/CLAUDE.md")" "$(cygpath -w "$REPO/CLAUDE.md")" > /dev/null 2>&1; then
  DEVMODE_OK=true
  cmd.exe //c mklink "$(cygpath -w "$CLAUDE/settings.json")"         "$(cygpath -w "$REPO/settings.json")"         > /dev/null
  cmd.exe //c mklink "$(cygpath -w "$CLAUDE/statusline-command.sh")" "$(cygpath -w "$REPO/statusline-command.sh")" > /dev/null
  echo "Symlinks:  CLAUDE.md, settings.json, statusline-command.sh"
else
  # Fallback: copy files (edits won't auto-sync — re-run install.sh after enabling Dev Mode)
  cp "$REPO/CLAUDE.md"             "$CLAUDE/CLAUDE.md"
  cp "$REPO/settings.json"         "$CLAUDE/settings.json"
  cp "$REPO/statusline-command.sh" "$CLAUDE/statusline-command.sh"
  echo ""
  echo "WARNING: File symlinks failed — Developer Mode is OFF."
  echo "  Files were COPIED instead. Changes to ~/.claude/CLAUDE.md etc."
  echo "  will NOT sync back to the repo automatically."
  echo ""
  echo "  To fix: Settings → System → Developer Mode → ON"
  echo "  Then re-run: bash install.sh"
fi

echo ""
echo "Done."
[ "$DEVMODE_OK" = true ] && echo "Status: fully symlinked." || echo "Status: dirs junctioned, files copied (enable Dev Mode to fix)."
