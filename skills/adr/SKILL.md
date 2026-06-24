---
name: adr
description: Write an ADR (Architecture Decision Record) to capture a technical/architecture decision — the context, the options considered with tradeoffs, the chosen decision, and its consequences. Use when the user wants to record a decision, document why an approach was chosen, or weigh architectural options.
---

# Architecture Decision Record (ADR)

Capture a single significant decision and the reasoning behind it, so it's understandable later.
Be honest about tradeoffs — an ADR with no downsides listed is usually incomplete.

An ADR is a narrow, append-only log entry for **one** decision. It links back up to the **Tech
Spec / PRD** that prompted it. Keep these as separate documents; reference, don't merge.

## Process

1. Confirm the decision being recorded and the context driving it. Ask if the problem or
   constraints aren't clear.
2. List the realistic options, each with its tradeoffs — don't strawman the rejected ones.
3. State the decision and its consequences, including what gets harder.

## Output template

```markdown
# ADR <NNN>: <Short title of the decision>

**Status:** Proposed | Accepted | Superseded by ADR-<NNN>   ·   **Date:** <date>

## Context
The forces at play: the problem, constraints, requirements, and assumptions that make this
decision necessary.

## Decision
The choice we are making, stated plainly.

## Options Considered
### Option A — <name>
- Pros:
- Cons:
### Option B — <name>
- Pros:
- Cons:
(Repeat as needed.)

## Consequences
- **Positive:** what improves.
- **Negative:** what gets harder, what we're accepting, what to revisit later.

## Related Docs
- The Tech Spec / PRD that prompted this decision: <link>
```

## Emphasis (backend-leaning)

Where relevant, address the **data model**, **API/contract** impact, and **security implications**
of the decision explicitly — these are the most expensive to get wrong.
