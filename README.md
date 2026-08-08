# Research Vault

An Obsidian vault for centrally viewing research notes that physically live in
per-project Dropbox folders (each shared with that project's coauthors).

## Design

- Notes are real files in `Dropbox/<Project>/Notes/`; Dropbox syncs them and
  handles coauthor sharing. Obsidian Sync stays OFF.
- This vault is a plain local folder OUTSIDE Dropbox. `Projects/` contains only
  symlinks (Mac) or junctions (Windows) into those Dropbox notes folders.
- The links are machine-local and gitignored; git carries the vault skeleton
  (`.obsidian` config, `Templates/`, `Concepts/`, `Bases/`) between machines.

## Setup on a new machine

1. Clone this repo anywhere outside Dropbox (e.g. `~/Obsidian/research-vault`).
2. Check `projects.txt`; if this machine's paths differ, copy it to
   `projects.local.txt` and edit (absolute paths allowed).
3. Run `./setup.sh` (Mac/Linux) or `.\setup.ps1` (Windows PowerShell).
4. In Obsidian: File > Open folder as vault, pick the cloned folder.

Note frontmatter follows the schemas in `Templates/`; `Bases/Projects.base`
renders a project dashboard over that frontmatter, and `hasTopic` links point
at the `Concepts/` hub notes. See `CLAUDE.md` for the full conventions and
`SETUP.md` for a from-scratch walkthrough.

## Rules

- One sync engine per folder: Dropbox owns note content; git owns the vault
  skeleton; never enable Obsidian Sync on this vault.
- Adding a project = one line in projects.txt + rerun the setup script.
- Notes may move freely inside a project's Notes folder; moving a note between
  projects is a Dropbox-side move between the two Notes folders.
