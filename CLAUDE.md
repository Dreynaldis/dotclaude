# CLAUDE.md -- Global

Personal context and standing directions for every Claude Code session.
Repo-specific rules live in each project's own `CLAUDE.md` and layer on top of this.

Only things the model can't infer belong here. Default behaviour is not written down.

## About Me

Full-stack developer, backend-leaning. Open to languages beyond the current stack
(node.js, express, typescript, nest.js).

- **Environment:** Windows 11. Main terminal is WezTerm running Git Bash (primary shell);
  PowerShell also available. Default to Bash/POSIX syntax for commands.

## Engineering Defaults

- **Surgical changes.** Edit only what the request requires. Don't improve, reformat, or
  refactor adjacent code. Match existing style.
- **Dependencies:** don't add one unless clearly better. If it is significantly better, ask
  first -- name it and give the reason.
- If you notice off-scope lint errors, test failures, or broken UI while working, flag them.
  Don't silently fix them unless asked.
- Recommend `/security-review` for sensitive diffs: auth, crypto, data access, file/network
  I/O, deserialization.

## Review Posture

- **Contract carve-out.** For my **work-company application**, do **not** alter existing
  architecture, data model, or API contracts unless I explicitly ask -- surface concerns, but
  treat its structure as fixed. A repo's own `CLAUDE.md` is the authority on whether it's
  review-only. Personal/portfolio projects get the full production-from-scratch posture.
- Before calling non-trivial work done, run the `scale-reviewer` agent. It owns the
  scalability checklist; don't restate it here.

## Planning Files

Six tiers, none continuously appended to -- that's what keeps them cheap to re-read.

- `BRAINSTORM.md` -- pre-decision exploration, freely rewritten.
- `CONTEXT.md` -- domain glossary only. Canonical terms, one-sentence definitions. No specs,
  no implementation details, no scratch notes.
- `docs/features/<slug>.md` -- written once, early: what the feature does and its scope. Not
  updated as implementation progresses.
- `docs/decisions/000N-<slug>.md` -- one ADR per decision (`adr` skill), made during
  implementation. Append-only via new files, never edited after. **Not** `docs/adr/`.
- `docs/completed/<slug>.md` -- written once, when the feature ships: distilled summary +
  gotchas, linking back to the feature spec and relevant ADRs. Keep short.
- `TODO.md` -- the only live file. Current state only, rewritten in place, stays short. Link
  to an ADR/feature/completed doc for "why"/"what" instead of inlining reasoning.

**The migration is not optional and not deferred.** The moment a `TODO.md` item is marked done,
extract its narrative into `docs/completed/<slug>.md` and cut the `TODO.md` entry to a one-line
pointer, in the same edit and same turn. A finding still awaiting a decision gets its own doc
under `docs/` rather than being inlined.

Start work by reading `TODO.md` plus only the specific docs it links, not conversation history.
For multi-phase work: finish a phase, update `TODO.md` / write an ADR, then start a fresh
session for the next phase.

## Commit Messages

No co-author or `Co-Authored-By` line for yourself, and no "Generated with Claude Code" footer.

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
- Surface multiple interpretations when a request is genuinely ambiguous in a way that changes
  the work. Routine judgment calls are yours to make.
