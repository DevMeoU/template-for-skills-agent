---
name: template-skill
description: "Use this skill whenever the user wants to <primary capability>. Triggers include: <trigger phrase>, <file type>, <workflow>, or requests to <specific outcome>. Also use when <related scenario>. Do NOT use for <explicit non-goals>."
license: Proprietary. LICENSE.txt has complete terms
---

# Template Skill title

## Overview

Explain what this skill enables the agent to do, when it is useful, and what the expected output looks like. Keep this short and operational.

## Quick Reference

| Task | Approach |
|------|----------|
| <Common task> | <Recommended approach> |
| <Common task> | <Recommended approach> |
| <Common task> | <Recommended approach> |

## Core Rules

- Use imperative, direct instructions.
- Ground outputs in user-provided context or repository-local evidence.
- Ask one focused question only when required to proceed safely.
- Do not include unnecessary process history, changelogs, or installation notes in the skill.

## Workflow

### Step 1: Collect inputs

List the inputs the agent should gather before acting.

```text
<path or input candidate>
<path or input candidate>
```

### Step 2: Analyze

Describe the decision process, checks, or transformations the agent should perform.

### Step 3: Produce output

Define what the final answer or artifact should include.

## Output Structure

Use this structure unless the user requests another format:

```markdown
## Summary

- <summary bullet>

## Details

- <detail bullet>

## Recommendations

1. <next step>
```

## Common Pitfalls

- Do not put trigger instructions only in the body; put them in the frontmatter description.
- Do not add files that the skill does not need.
- Do not make the skill so broad that it triggers on unrelated tasks.

## Dependencies

- <Required tool or dependency, or "None">
