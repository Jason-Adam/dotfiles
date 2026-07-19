# thoughts

Central, cross-project store for agent-generated research, plans, and handoffs.

Symlinked to `~/thoughts` by `syms.sh`, so every project writes to one place.
Documents are namespaced by repository:

```
~/thoughts/
└── <repo>/                 # basename of the project's git root
    ├── research/           # rpi-research output (YYYY-MM-DD-HHmm-topic.md)
    ├── plans/              # rpi-plan output
    └── handoffs/           # handoff output (YYYY-MM-DD.md)
```

## Who reads/writes here

- Write: `rpi-research`, `rpi-plan`, `handoff`
- Read: `thoughts-locator` + `thoughts-analyzer` (discover/analyze prior notes),
  `rpi-implement`, `rpi-iterate`, `resume-handoff`

## Privacy

This dotfiles repo is **public**, so note *content* is git-ignored (see
`.gitignore`): only this README and the directory structure are tracked. The notes
themselves stay local. To sync them across machines, use a separate private repo.
