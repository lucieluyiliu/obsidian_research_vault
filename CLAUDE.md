# Research Vault - Claude Instructions

This folder is an Obsidian vault: a central VIEW over research notes that
physically live in per-project Dropbox folders. It is a git repo; the notes
themselves are NOT in this repo.

## Architecture rules

1. Notes live in `Dropbox/<Project>/Notes/`, inside each project's shared
   folder. Dropbox syncs them and handles coauthor sharing. Never move note
   files into the vault itself.
2. `Projects/` contains only machine-local links (symlinks on Mac, junctions
   on Windows) into those Dropbox notes folders. Links are gitignored and
   recreated per machine from `projects.txt` by the setup scripts.
3. This vault folder must live OUTSIDE Dropbox. Never create links inside a
   Dropbox-synced folder.
4. One sync engine per folder: Dropbox owns note content, git owns the vault
   skeleton. Never enable Obsidian Sync on this vault.
5. Never delete notes. Files reached through `Projects/` links are shared
   coauthor territory; edit with the same care as the project's own repo.

## Machine setup

- Adding a project or a machine: edit `projects.txt` (machine-specific paths
  go in `projects.local.txt`, gitignored), then run `./setup.sh` (Mac/Linux)
  or `.\setup.ps1` (Windows PowerShell; junctions, no admin needed).
- The scripts auto-detect the Dropbox root (`~/Library/CloudStorage/Dropbox`
  or `~/Dropbox` on Mac; `%USERPROFILE%\Dropbox` on Windows).
- Windows: if Dropbox uses online-only files, mark the notes folders
  "Make available offline" before linking.
- Machine-specific plugin paths in `.obsidian/` (e.g. the citation plugin's
  bib export path) are fixed locally, not committed.

## Note conventions

- Frontmatter schemas follow `Templates/` - treat these as the written spec
  when drafting or converting notes, not as optional boilerplate.
- Project hub notes are tagged `#project` and carry `status`, `with`,
  `targetVenue`, `hasTopic`; `Bases/Projects.base` renders the dashboard
  over exactly these fields.
- `hasTopic` entries link to stub notes in `Concepts/` (cross-project hubs).
  Add a concept stub rather than leaving a dangling link.
- A new recurring note type gets a new template in `Templates/`, not ad-hoc
  frontmatter.
