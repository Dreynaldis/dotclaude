---
name: prd
description: Write, draft, or update a PRD (Product Requirements Document) / product spec / product requirements. Use when the user wants to define what a product or feature is, who it's for, the problem it solves, success criteria, or wants to iterate on an existing PRD as a living document.
---

# PRD Writer

A PRD is a **living document** that bridges business, design, and engineering — and stays useful
after launch (improvements, blockers, follow-ups). Never dump a finished PRD in one shot. Start
from what's known, propose, and **iterate back and forth** with the user.

This is the *what & why* doc. It links down to a **Tech Spec** (the *how*), which links down to
**ADRs** (individual decisions). Keep them as separate documents; reference, don't merge.

## Process

1. **Gather, don't assume.** Ask targeted questions to fill the formula below. If the user already
   gave some answers, restate your understanding and ask only about the gaps.
2. **Propose a draft**, then refine it with the user across turns. Treat every later message as an
   edit to the same living doc — keep it consistent, and update the *Open Questions* and
   *Changelog* sections as things get resolved.
3. **Adapt as the product grows.** When scope or understanding changes, revise the relevant
   sections rather than starting over, and record what changed.

## The formula (must be answered)

- **What are we building** — the product/program in one or two sentences.
- **Successful outcome** — what success concretely looks like, with **measurable** criteria/metrics.
- **Target / who uses it** — the audience and key personas.
- **Core features → problem** — define the core features as solutions to the stated problem. Map
  each feature to the problem it solves; this is not a feature dump.

## Output template

```markdown
# PRD: <Product / Feature name>

**Status:** Draft | In review | Approved   ·   **Last updated:** <date>

## 1. Overview / Vision
What we're building and why, in a few sentences.

## 2. Success Criteria & Metrics
What a successful outcome looks like. Measurable targets (KPIs, adoption, performance, etc.).

## 3. Users / Personas
Who this is for and who actually uses it.

## 4. Problem Statement
The problem(s) we're solving, and the cost of not solving them.

## 5. Core Features (problem → solution)
| Feature | Problem it solves | Notes |
|---|---|---|

## 6. Non-Goals
Explicitly out of scope.

## 7. Open Questions
Unresolved decisions, with owners where known.

## 8. Risks & Blockers
Known risks, dependencies, and blockers.

## 9. Post-Launch / Iteration Log
Planned improvements, follow-ups, and a changelog of significant updates to this doc.

## 10. Related Docs
- Tech Spec(s) that implement this PRD: <link>
- (The PRD says *what & why*; the Tech Spec says *how*; ADRs record individual decisions.)
```

## Cross-functional framing

Write each section so business, design, and engineering can all use it: business reads outcome &
metrics, design reads users & problem, engineering reads core features & non-goals. Keep it
concrete enough to act on, not aspirational filler.
