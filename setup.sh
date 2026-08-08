#!/usr/bin/env bash
# Recreate Projects/ symlinks from projects.txt (or projects.local.txt if present).
# Run from anywhere: ./setup.sh
set -e
cd "$(dirname "$0")"

# $DROPBOX from the environment wins if set; otherwise look in the usual places.
# Not finding it is only fatal for lines that use $DROPBOX -- absolute paths still work.
for d in "$DROPBOX" "$HOME/Library/CloudStorage/Dropbox" "$HOME/Dropbox"; do
  if [ -n "$d" ] && [ -d "$d" ]; then DROPBOX="$d"; break; fi
done

LIST=projects.txt
[ -f projects.local.txt ] && LIST=projects.local.txt

mkdir -p Projects
while IFS='|' read -r name target; do
  case "$name" in ''|\#*) continue;; esac
  case "$target" in
    *'$DROPBOX'*)
      if [ ! -d "$DROPBOX" ]; then
        echo "SKIP $name: Dropbox folder not found; set \$DROPBOX or use absolute paths in projects.local.txt" >&2
        continue
      fi;;
  esac
  target="${target//\$DROPBOX/$DROPBOX}"
  if [ ! -d "$target" ]; then echo "SKIP $name: target not found: $target" >&2; continue; fi
  ln -sfn "$target" "Projects/$name"
  echo "OK   $name -> $target"
done < "$LIST"
