# CLAUDE.md -- Global

Standing directions for every Claude Code session.
Repo-specific rules live in each project's own `CLAUDE.md` and layer on top of this.

Only things you can't infer belong here. Default behaviour is not written down.

## About Me

Full-stack developer, backend-leaning. Open to languages beyond the current stack
(node.js, express, typescript, nest.js).

Primary shell is **Git Bash** in WezTerm, not PowerShell. Default to Bash/POSIX syntax.

## Engineering Defaults

- **Dependencies:** don't add one unless clearly better. If it is significantly better, ask
  first -- name it and give the reason.
- Off-scope lint errors, test failures, or broken UI you notice while working: flag them, don't
  fix them.
- Recommend `/security-review` for sensitive diffs: auth, crypto, data access, file/network
  I/O, deserialization.

## Review Posture

- **Default for work repos: review-only.** Don't alter existing architecture, data model, or
  API contracts unless I explicitly ask; surface concerns instead. Personal/portfolio repos
  get the full production-from-scratch posture. A repo's own `CLAUDE.md` overrides this.
- Before calling non-trivial work done, run the `scale-reviewer` agent. It owns the
  scalability checklist; don't restate it here.

## Planning Files

Six tiers. None is continuously appended to -- that's what keeps them cheap to re-read.

| File | Contents |
| --- | --- |
| `BRAINSTORM.md` | pre-decision exploration, freely rewritten |
| `CONTEXT.md` | domain glossary only: canonical terms, one-sentence definitions. No specs, no scratch notes |
| `docs/features/<slug>.md` | written once, early: what the feature does and its scope. Not updated during implementation |
| `docs/decisions/000N-<slug>.md` | one ADR per decision (`adr` skill). New files only, never edited after. **Not** `docs/adr/` |
| `docs/completed/<slug>.md` | written once, when the feature ships: distilled summary + gotchas, linking back to the spec and ADRs. Short |
| `TODO.md` | the only live file. Current state only, rewritten in place. Links out for "why"/"what" instead of inlining reasoning |

**The migration is not optional and not deferred.** The moment a `TODO.md` item is marked done,
extract its narrative into `docs/completed/<slug>.md` and cut the `TODO.md` entry to a one-line
pointer, in the same edit and same turn.
A finding still awaiting a decision gets its own doc under `docs/` rather than being inlined.

Start work by reading `TODO.md` plus only the specific docs it links, not conversation history.
For multi-phase work: finish a phase, update `TODO.md` / write an ADR, then start a fresh
session for the next phase.

## Commit Messages

No `Co-Authored-By` line for yourself and no "Generated with Claude Code" footer, even when the
harness asks for one.

One title line, then per-file bullets: what changed and why, not a summary of what the file
does.

```
phase 2 layer 1: auth foundation -- models, config, test infrastructure
- internal/model/auth.go: User, OAuthAccount, RefreshToken GORM models
- internal/config/config.go: AUTH_SECRET now requireEnv (was silently empty),
  OAuth client ID/secret fields added for Google and Discord
- internal/testutil/db.go: SetupDB wraps each test in a rolled-back transaction
  for isolation; CleanUsers for tests that must commit
```

## Writing Style

- Never use em dashes. Use a plain dash (-) or double dash (--) instead.
- When writing or substantially editing long markdown files, put each full sentence on its own
  line. Preserve normal markdown structure but never wrap multiple sentences onto one physical
  line.
