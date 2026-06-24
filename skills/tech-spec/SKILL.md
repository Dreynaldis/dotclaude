---
name: tech-spec
description: Write a technical design doc / tech spec / RFC before building a feature — the problem, proposed design, data model and API/schema changes, alternatives, security considerations, risks, rollout, and testing. Use when the user asks how something should be built, wants a design doc/RFC, or is planning a non-trivial feature before coding.
---

# Tech Spec / RFC

A design doc written **before building**, so the approach can be reviewed cheaply. Favor a
concrete proposed design over a survey of possibilities, but record the alternatives you rejected.
Apply the security guardrails from the global `CLAUDE.md`.

This is the *how* doc. It links **up** to a **PRD** (the *what & why*) and **down** to **ADRs**
(individual decisions made along the way). Keep them separate; reference, don't merge.

## Process

1. Pin down the problem and the goals/non-goals first; ask if they're fuzzy.
2. Propose one primary design in enough detail to implement, then iterate with the user.
3. Don't skip security, rollout, and testing — these are where specs usually go thin.

## Output template

```markdown
# Tech Spec: <Feature / system name>

**Status:** Draft | In review | Approved   ·   **Author:** <me>   ·   **Date:** <date>

## 1. Summary
One paragraph: what we're building and the approach, at a glance.

## 2. Problem, Goals & Non-Goals
- Problem:
- Goals (measurable where possible):
- Non-goals:

## 3. Proposed Design
The primary approach in implementable detail:
- Architecture / components and how they interact
- Data model (tables/entities, key fields, relationships, migrations)
- API / GraphQL schema changes (queries, mutations, types, contracts)

## 4. Alternatives Considered
Other approaches and why they were rejected.

## 5. Security & Privacy
Authn/authz impact, input validation, injection surfaces, secrets/PII handling, data exposure.
Flag anything that warrants `/security-review`.

## 6. Risks & Mitigations
What could go wrong and how we de-risk it.

## 7. Rollout / Migration Plan
Sequencing, feature flags, data migration, backward compatibility, and rollback.

## 8. Testing Strategy
How correctness is validated: unit/integration/e2e, key cases, and what "done" means.

## 9. Open Questions
Unresolved decisions and dependencies.

## 10. Related Docs
- **Up:** the PRD this spec implements (the *what & why*): <link>
- **Down:** ADRs spawned by this spec (individual decisions + tradeoffs): <links>
```
