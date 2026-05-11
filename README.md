# Arch Rules Skills

Навыки для агентов, которые превращают архитектурные правила из большого документа в рабочий контекст для планирования, реализации и ревью.

Этот репозиторий не хранит сами правила. Он учит агента брать baseline из [ai-meatbags/arch-rules](https://github.com/ai-meatbags/arch-rules) или из project-pinned копии и применять его к конкретной задаче.

## Зачем Это Нужно

Архитектурный baseline сам по себе бесполезен, если агент его просто прочитал и пошёл писать код как обычно. Нужен слой, который заставляет агента:

- найти правильный источник правил;
- выбрать применимые AP-ID;
- явно сказать, какие правила не применимы;
- заметить конфликт до кода;
- превратить правила в план, slices и review gates.

Эти skills закрывают работу:

> У меня есть архитектурные правила, но я не хочу каждый раз вручную объяснять агенту, как их читать, какие правила выбирать, как не превратить baseline в чеклист на 100 пунктов и когда надо остановиться вместо “ну я примерно понял”.

`arch-rules-skills` делает правила исполнимыми для агента. Не в смысле автоматической магии, а в смысле повторяемого рабочего протокола.

## Что Внутри

В пакете три skills:

- `arch-rules-context` - находит baseline, читает проектные документы и создаёт `Architecture Context Map`.
- `arch-rules-slice-planning` - превращает архитектурный контекст в implementation slices по границам, а не по случайным файлам.
- `arch-rules-implementation-review` - проверяет реализацию против архитектурных gates, а не только против тестов.

Их роли разделены специально:

- context skill отвечает за “какие правила вообще применимы”;
- planning skill отвечает за “как строить работу, чтобы не сломать границы”;
- review skill отвечает за “что реально нарушено и почему это важно”.

## Зависимости

Пакет не standalone. Ему нужны:

- [Superpowers](https://github.com/obra/superpowers) или эквивалентные навыки планирования, TDD и verification gates;
- читаемый architecture baseline.

Полезные ссылки:

- Superpowers source: https://github.com/obra/superpowers
- Claude Superpowers plugin: https://claude.com/plugins/superpowers
- Codex Superpowers install guide: https://github.com/obra/superpowers/blob/main/docs/README.codex.md
- Default architecture baseline: https://github.com/ai-meatbags/arch-rules

Минимальная поверхность Superpowers:

- `superpowers:brainstorming`
- `superpowers:writing-plans`
- `superpowers:test-driven-development`
- `superpowers:verification-before-completion`

## Откуда Брать Архитектурные Правила

Агент должен искать baseline в таком порядке:

1. Project-local policy или docs:
   - `AGENTS.md`
   - `docs/project-arch-rules.md`
   - `docs/arch-rules.md`
   - `docs/architecture.md`
   - `.agents/`
2. URL или repo, явно названный пользователем.
3. Default public baseline: https://github.com/ai-meatbags/arch-rules

Если выбранный baseline нельзя прочитать, агент обязан остановиться до планирования и до кода.

Fail-fast форма:

```text
Cannot start arch-rules workflow.
Missing: <Superpowers skill | arch-rules skill | readable architecture-rules baseline>
Tried: <paths and URLs checked>
Next action: <install dependency or provide baseline URL/path>
```

Нельзя продолжать с “общими best practices”, если baseline не прочитан.

## Как Это Работает

Нормальный поток:

1. Установить или подтвердить Superpowers.
2. Установить все `arch-rules-*` skills из этого repo.
3. В целевом проекте найти baseline.
4. Запустить `arch-rules-context`.
5. Получить `Architecture Context Map`.
6. Только после этого использовать `arch-rules-slice-planning` или `arch-rules-implementation-review`.

`Architecture Context Map` должен выглядеть примерно так:

```markdown
Architecture Context Map
- Stage: mvp | prod | scale
- Source docs: ...
- Critical AP gates: AP-...
- Baseline AP gates: AP-...
- Not applicable: AP-... because ...
- Deviations: none | ...
- Plan decisions still open: ...
```

Это не отчёт ради отчёта. Это рабочая выжимка из baseline для конкретной задачи.

## Когда Использовать

Используй эти skills, когда агент:

- пишет план по feature/spec;
- делает архитектурное ревью;
- проверяет реализацию перед завершением;
- разбивает работу на slices;
- спорит с предложенным решением через AP-ID;
- должен понять, какие архитектурные правила применимы именно здесь.

Не используй их как замену самим правилам. Эти skills - процесс применения baseline, а не baseline.

## Установка В Codex

Сначала установи или подтверди Superpowers.

Инструкция для агента:

```text
Install or confirm Superpowers first.
Install all skills from https://github.com/VanDalkvist/arch-rules-skills/tree/main/skills into Codex.
Use the Codex skill-installer flow if available. Install every arch-rules-* skill.
Before using the skills, locate a project-pinned architecture-rules baseline or use the default public baseline at https://github.com/ai-meatbags/arch-rules.
Fail fast if Superpowers, any arch-rules-* skill, or a readable baseline is missing.
After installation, restart Codex so the skills are discovered.
```

Ручной fallback:

```sh
git clone https://github.com/VanDalkvist/arch-rules-skills.git
cd arch-rules-skills
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
cp -R skills/arch-rules-* "${CODEX_HOME:-$HOME/.codex}/skills/"
```

## Установка В Claude Code

Сначала установи Superpowers plugin или подтверди эквивалентные Superpowers skills: https://claude.com/plugins/superpowers

Personal install:

```sh
git clone https://github.com/VanDalkvist/arch-rules-skills.git
cd arch-rules-skills
mkdir -p "$HOME/.claude/skills"
cp -R skills/arch-rules-* "$HOME/.claude/skills/"
```

Project install:

```sh
git clone https://github.com/VanDalkvist/arch-rules-skills.git
cd your-project
mkdir -p .claude/skills
cp -R ../arch-rules-skills/skills/arch-rules-* .claude/skills/
```

Claude Code skills documentation: https://code.claude.com/docs/en/skills

## Проверка

```sh
find skills -name SKILL.md -maxdepth 3 -print
grep -R "<project-specific-name>\|<absolute-home-path>\|<private-user-name>" -n skills docs README.md AGENTS.md scripts || true
```

Для Codex schema validation:

```sh
for skill in skills/arch-rules-*; do
  uv run --with pyyaml python "$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py" "$skill"
done
```

## Связь С Другими Репозиториями

Порядок установки полного набора:

1. [Superpowers](https://github.com/obra/superpowers)
2. [arch-rules-skills](https://github.com/VanDalkvist/arch-rules-skills)
3. [arch-improvement-skills](https://github.com/VanDalkvist/arch-improvement-skills)

`arch-improvement-skills` зависит от этого пакета. Этот пакет зависит от readable baseline, например [ai-meatbags/arch-rules](https://github.com/ai-meatbags/arch-rules).

## License

MIT.
