# Setting Up This Note System From Scratch

For a new machine, or a new person adopting the system. Each step is small;
you can hand this file to Claude Code and ask it to walk through it with you.

## The design in one paragraph

Notes for each project live as plain markdown in that project's Dropbox
folder (`Dropbox/<Project>/Notes/`), so they sync and can be shared with
coauthors per project. Obsidian never stores the notes; it opens this vault,
which contains only links to those folders plus shared configuration
(templates, concept hubs, dashboards). The vault skeleton travels between
machines via git; the links are rebuilt locally on each machine; Obsidian
Sync stays off.

## Prerequisites

- Dropbox installed and synced
- Obsidian installed
- git installed

## Steps

1. **Project folders.** Each project needs a Dropbox folder with a `Notes/`
   subfolder (create them if starting fresh). Share the project folder with
   that project's coauthors via Dropbox; notes ride along automatically.
2. **Clone the vault** anywhere OUTSIDE Dropbox, e.g. `~/Obsidian/research-vault`
   (Mac) or `C:\Users\<you>\Obsidian\research-vault` (Windows).
3. **List your projects.** Edit `projects.txt`: one line per project,
   `<link-name>|$DROPBOX/<Project>/Notes`. If this machine's paths are
   unusual, copy to `projects.local.txt` (gitignored) and use absolute paths.
4. **Create the links.** Mac/Linux: `./setup.sh`. Windows PowerShell:
   `.\setup.ps1` (uses junctions; no admin rights needed). Rerun any time
   the project list changes.
5. **Open the vault.** Obsidian > Open folder as vault > pick the cloned
   folder. Verify each folder under `Projects/` shows the project's notes.
6. **Do not enable Obsidian Sync.** Dropbox is the sync engine for notes;
   git for the vault skeleton.

## Mobile (optional, read access)

The Dropbox mobile app opens any note read-only. For rendered markdown, a
Dropbox-native reader (e.g. 1Writer on iOS) pointed at the project Notes
folders works well. Do not point Obsidian Sync or any second sync engine at
folders Dropbox already syncs.
