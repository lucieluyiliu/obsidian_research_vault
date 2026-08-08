#!/usr/bin/env bash
# Recreate Projects/ symlinks from projects.txt (or projects.local.txt if present).
# Run from anywhere: ./setup.sh
set -e
cd "$(dirname "$0")"

DROPBOX=""
for d in "$HOME/Library/CloudStorage/Dropbox" "$HOME/Dropbox"; do
  if [ -d "$d" ]; then DROPBOX="$d"; break; fi
done
if [ -z "$DROPBOX" ]; then echo "Dropbox folder not found; edit setup.sh or use absolute paths in projects.local.txt" >&2; exit 1; fi

LIST=projects.txt
[ -f projects.local.txt ] && LIST=projects.local.txt

mkdir -p Projects
while IFS='|' read -r name target; do
  case "$name" in ''|\#*) continue;; esac
  target="${target//\$DROPBOX/$DROPBOX}"
  if [ ! -d "$target" ]; then echo "SKIP $name: target not found: $target" >&2; continue; fi
  ln -sfn "$target" "Projects/$name"
  echo "OK   $name -> $target"
done < "$LIST"
