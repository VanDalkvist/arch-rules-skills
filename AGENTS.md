# Agent Instructions

This repository contains portable architecture-rule skills. Keep it generic and open-source safe.

## Rules

- Do not add machine-specific paths, private repository names, tokens, chat contents, or user-specific memory.
- Keep skills under `skills/<skill-name>/SKILL.md`.
- Do not bake a private architecture baseline into the skills. The baseline must come from the target project or a public upstream named by project policy.
- Keep Superpowers as an explicit dependency in docs.
- Before publishing, check for local coupling:

```sh
grep -R "<project-specific-name>\|<absolute-home-path>\|<private-user-name>\|<private-provider>" -n skills docs README.md AGENTS.md scripts || true
```

- Validate Codex skill frontmatter with `quick_validate.py` when available.
