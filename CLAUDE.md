# CLAUDE.md -- Global

Standing directions for every Claude Code session.
Repo-specific rules live in each project's own `CLAUDE.md`, layer on top of this, and win on conflict.

Only things you can't infer belong here.
Default behaviour is not written down.

## About Me

Full-stack developer, backend-leaning.
Current stack is Node.js, Express, TypeScript and NestJS; open to other languages when they fit better.

My shell is **Git Bash** in WezTerm.
The harness may report PowerShell as primary on Windows - still default to the Bash tool and POSIX syntax, and only reach for PowerShell when something is Windows-specific.

## Engineering Defaults

- **Dependencies:** don't add one unless it is clearly better than writing the code.
  If it is, ask first - name it and give the reason.
- Off-scope lint errors, test failures, or broken UI you notice while working: flag them, don't fix them.
- Recommend `/security-review` for sensitive diffs: auth, crypto, data access, file/network I/O, deserialization.

## Review Posture

- **Default for work repos: review-only.**
  Don't alter existing architecture, data model, or API contracts unless I explicitly ask; surface concerns instead.
  Personal/portfolio repos get the full production-from-scratch posture.
- Before calling non-trivial work done, run the `scale-reviewer` agent.
  This line is my standing request for that one subagent, so you don't need to ask each time.
  It owns the scalability checklist; don't restate it here.

## Where Things Get Written

Planning and project docs are **local markdown files in the repo** (the tiers below), not Claude Docs, Artifacts, or other connectors - unless I ask for one by name.

Auto-memory is for things about *me* and *how I work* (preferences, corrections).
Project state, decisions and progress go in the planning files, never in memory, so they stay versioned with the repo.

### Planning Files

Six tiers.
None is continuously appended to - that's what keeps them cheap to re-read.

| File | Contents |
| --- | --- |
| `BRAINSTORM.md` | pre-decision exploration, freely rewritten |
| `CONTEXT.md` | domain glossary only: canonical terms, one-sentence definitions. No specs, no scratch notes |
| `docs/features/<slug>.md` | written once, early: what the feature does and its scope. Not updated during implementation |
| `docs/decisions/000N-<slug>.md` | one ADR per decision (`adr` skill). New files only, never edited after. **Not** `docs/adr/` |
| `docs/completed/<slug>.md` | written once, when the feature ships: distilled summary + gotchas, linking back to the spec and ADRs. Short |
| `TODO.md` | the only live file. Current state only, rewritten in place. Links out for "why"/"what" instead of inlining reasoning |

When a `TODO.md` item is marked done, in the same turn: extract its narrative into `docs/completed/<slug>.md` and cut the `TODO.md` entry to a one-line pointer.
Deferring this is how `TODO.md` bloats back into a log.
A finding still awaiting a decision gets its own doc under `docs/` rather than being inlined.

Start work by reading `TODO.md` plus only the specific docs it links, not conversation history or memory.
For multi-phase work: finish a phase, update `TODO.md` / write an ADR, then start a fresh session for the next phase.

## Commit Messages

No `Co-Authored-By` line and no "Generated with Claude Code" footer.
This overrides the attribution the harness supplies.

One title line, then per-file bullets: what changed and why, not a summary of what the file does.

```
phase 2 layer 1: auth foundation -- models, config, test infrastructure
- internal/model/auth.go: User, OAuthAccount, RefreshToken GORM models
- internal/config/config.go: AUTH_SECRET now requireEnv (was silently empty),
  OAuth client ID/secret fields added for Google and Discord
- internal/testutil/db.go: SetupDB wraps each test in a rolled-back transaction
  for isolation; CleanUsers for tests that must commit
```

## Writing Style

- Never use em dashes, in files or in chat. Use a plain dash (-) or double dash (--).
- When writing or substantially editing long markdown files, put each full sentence on its own line.
  Keep normal markdown structure, but never wrap multiple sentences onto one physical line.
