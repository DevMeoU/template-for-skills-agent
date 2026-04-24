# Template for Skills Agent

template-for-skills-agent is a starter template for creating Anthropic-style Agent Skills.

This repository provides:

- `template-skill/` — minimal skill folder following the common `SKILL.md` format
- `scripts/new-skill.ps1` — create a new skill folder from the template
- `scripts/validate-skill.ps1` — lightweight local validation

## Skill shape

```text
my-skill/
  SKILL.md      # required
  LICENSE.txt   # optional but recommended when frontmatter has license
  scripts/      # optional executable helpers
  references/   # optional docs loaded only when needed
  assets/       # optional output assets/templates
```

## Frontmatter format

Use the common Anthropic-style form:

```yaml
---
name: my-skill
description: "Use this skill whenever the user wants to <capability>. Triggers include: <phrases>, <file types>, or requests to <outcomes>. Do NOT use for <non-goals>."
license: Proprietary. LICENSE.txt has complete terms
---
```

Guidelines:

- `name` is required and should be lowercase hyphen-case.
- `description` is required and should be explicit and trigger-oriented.
- Include both what the skill does and when to use it.
- Put trigger instructions in the description, not only in the body.
- Add a `license` field only if you include the matching license terms file.

## Create a new skill

```powershell
powershell -ExecutionPolicy Bypass -File ./scripts/new-skill.ps1 -Name supervisor-agents -Output ./dist
```

This creates:

```text
dist/supervisor-agents/SKILL.md
dist/supervisor-agents/LICENSE.txt
```

Then edit `SKILL.md`:

1. Replace description placeholders.
2. Fill in Overview.
3. Update Quick Reference.
4. Write concrete workflow steps.
5. Define output structure and dependencies.

## Validate

```powershell
powershell -ExecutionPolicy Bypass -File ./scripts/validate-skill.ps1 ./template-skill
powershell -ExecutionPolicy Bypass -File ./scripts/validate-skill.ps1 ./dist/supervisor-agents
```

If you have Anthropic/OpenClaw skill creator scripts available, also run their official validator.

## Recommended SKILL.md structure

```markdown
# Skill Title

## Overview

## Quick Reference

| Task | Approach |
|------|----------|

## Core Rules

## Workflow

### Step 1: Collect inputs
### Step 2: Analyze or transform
### Step 3: Produce output

## Output Structure

## Common Pitfalls

## Dependencies
```

## What not to put in a skill folder

Avoid extra docs inside the skill itself unless they are intentionally loaded references.

Do not add:

```text
README.md
CHANGELOG.md
INSTALLATION_GUIDE.md
QUICK_REFERENCE.md
```

Use `references/` for detailed domain material and point to it from `SKILL.md` only when needed.

## Example workflow

```powershell
# Create a new skill
powershell -ExecutionPolicy Bypass -File ./scripts/new-skill.ps1 -Name code-review-supervisor -Output ./dist

# Edit the generated skill
code ./dist/code-review-supervisor/SKILL.md

# Validate
powershell -ExecutionPolicy Bypass -File ./scripts/validate-skill.ps1 ./dist/code-review-supervisor
```
