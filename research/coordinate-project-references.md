# Project coordinator workflow references

Checked 2026-10-15 against first-party GitHub repositories. These findings describe source instructions and repository artifacts, not independently tested runtime behavior. The existing `coordinate-project` skill was read for comparison and left unchanged.

## Closest reference: Cursor pstack orchestration

Pstack's [orchestrate playbook](https://github.com/cursor/plugins/blob/main/pstack/skills/poteto-mode/playbooks/orchestrate.md) directly describes a standing coordinator chat for multi-day projects spanning many agents and PRs. The coordinator retains project direction, delegates execution, maintains durable state, integrates results, and presents human decisions. Useful patterns:

- Scale ceremony with the effort and avoid extra coordinator layers until needed.
- Give workers explicit outcomes, write ownership, acceptance criteria, verification methods, and handoff requirements.
- Treat dependencies as evidence handoffs: downstream workers need upstream findings, not merely completion status.
- Process completions at safe coordination points; reconcile watcher wakeups with a longer heartbeat fallback.
- Test a representative unit through the delegation and verification process before scaling.
- Associate verification with a particular PR/head; changed artifacts require current evidence.
- Track every worker through a terminal outcome, including failed or abandoned work.
- Defer discoveries that do not block the agreed outcome.

Fit limits: it targets much larger programs, assumes Cursor-specific tools and cloud workers, and includes stack/merge operations. Its multiple ledgers and state CLI would be excessive for many short-lived experiments. Borrow the protocol, adapting runtime and permissions, rather than importing the entire workflow.

The smaller [swarm skill](https://github.com/cursor/plugins/blob/main/pstack/skills/swarm/SKILL.md) complements this with a completion condition, self-contained bounded assignments, explicit evidence, and consolidated reporting. It is a single parallel work wave rather than the full project lifecycle.

Snapshot: cursor/plugins main at `99743e9c151c8537cbbf1f98bb38f34ef3368453`. Pstack is [MIT licensed](https://github.com/cursor/plugins/blob/main/pstack/LICENSE).

## Matt Pocock: coordinator role, triggers, and dependency graphs

The [chief-of-staff skill](https://github.com/mattpocock/skills/blob/main/skills/in-progress/chief-of-staff/SKILL.md) is a close conceptual match: one session owns a long-running goal, keeps strategic context, coordinates background subagents, suggests schedules where supported, and communicates through concise pointers to shared artifacts. Its tactical/strategic distinction is useful. Its requirements to delegate all work and continually improve the surrounding environment should not become unconditional scope expansion in a bounded project.

The [loop-me skill](https://github.com/mattpocock/skills/blob/main/skills/in-progress/loop-me/SKILL.md) designs workflows rather than executing them. It separates event/schedule triggers, human checkpoints, and concise decision briefs. Schedules and checkpoints are chosen for the workflow rather than mandatory. This supports worker reports plus optional periodic reconciliation and human review of a prepared recommendation.

Both are explicitly [beta, excluded from the standard plugin and top-level documentation, and subject to change](https://github.com/mattpocock/skills/blob/main/skills/in-progress/README.md). Their presence on main does not mean a normal plugin install provides them.

The more established [implement-spec](https://github.com/mattpocock/skills/blob/main/skills/engineering/implement-spec/SKILL.md) treats work as a dependency graph and starts newly unblocked units as predecessors finish. [To-tickets](https://github.com/mattpocock/skills/blob/main/skills/engineering/to-tickets/SKILL.md) supports both local files and a real issue tracker, using verifiable vertical slices and explicit blocking relationships. These are useful execution references, but the integration-branch, ticket-per-worker, merge, and automatic-ready-for-review choices in `implement-spec` do not match every project or this user's PR policy.

[Wayfinder](https://github.com/mattpocock/skills/blob/main/skills/engineering/wayfinder/SKILL.md) is an adjacent planning workflow. It retains the destination and decisions while separating unresolved in-scope questions from excluded work. It is helpful when the path is still unclear; its default output is resolved decisions rather than implemented deliverables.

Snapshot: mattpocock/skills main at `49dd158d1076134a641b33efb035946536778336`. The repo is [MIT licensed](https://github.com/mattpocock/skills/blob/main/LICENSE).

## obra/superpowers

[obra/superpowers](https://github.com/obra/superpowers) is the active source repository; it identifies itself as an agentic skills framework and is MIT licensed ([LICENSE](https://github.com/obra/superpowers/blob/main/LICENSE)). Its value here is execution discipline at the task level. [Subagent-driven development](https://github.com/obra/superpowers/blob/main/skills/subagent-driven-development/SKILL.md) calls for a fresh implementer per plan task, a spec-compliance and code-quality review after each task, then a whole-branch review. It explicitly says to keep executing without asking the human between tasks. [Dispatching parallel agents](https://github.com/obra/superpowers/blob/main/skills/dispatching-parallel-agents/SKILL.md) reserves parallel dispatch for independent problem areas, uses sequential agents when work shares state, and requires each brief to give scope, goal, constraints, and expected output; the coordinator integrates and checks the combined changes. [Writing plans](https://github.com/obra/superpowers/blob/main/skills/writing-plans/SKILL.md) presents a plan for human review before implementation, while [executing plans](https://github.com/obra/superpowers/blob/main/skills/executing-plans/SKILL.md) uses batch review checkpoints.

Reusable: focused self-contained worker briefs, bounded parallelism, explicit result review, and human review at plan or batch boundaries rather than after every small task. Fit limit: these skills organize one development plan in a coding-agent session. The cited workflows do not provide a durable cross-session project ledger, external issue-to-worker mapping, or persistent visible-chat monitoring.

## GSD: get-shit-done → gsd-core

The originally named [gsd-build/get-shit-done](https://github.com/gsd-build/get-shit-done) repository is archived read-only (June 26, 2026); its README points to [open-gsd/gsd-core](https://github.com/open-gsd/gsd-core) as the current source. The comparison below uses that repository’s `next` branch. Both repositories identify MIT licensing ([archived package metadata](https://github.com/gsd-build/get-shit-done/blob/main/package.json), [current repository](https://github.com/open-gsd/gsd-core)).

GSD’s distinctive pattern is a durable project state plus a dashboard loop. Its [STATE.md template](https://github.com/open-gsd/gsd-core/blob/next/gsd-core/templates/state.md) records core value, current phase and plan, progress, decisions, blockers, deferred items, and where the last session stopped; it says workflows read this first and update it after significant actions. The [manager workflow](https://github.com/open-gsd/gsd-core/blob/next/gsd-core/workflows/manager.md) renders phase status and dependencies, offers a user-selected `Continue` that lists all recommended actions, dispatches plan/execute work in the background only when the runtime supports nested agents, then refreshes its dashboard. While agents run it defaults to a 60-second refresh, configurable or disabled. At phase completion it offers verification and milestone wrap-up. The [execute-phase workflow](https://github.com/open-gsd/gsd-core/blob/next/gsd-core/workflows/execute-phase.md) groups plans into dependency waves, dispatches workers, handles checkpoints, collects results, and verifies completion.

Reusable: compact durable state, dependency-aware fan-out, a user-visible next-action menu, and an optional active-work refresh loop. Fit limit: these are instructions for a substantial local planning runtime with its own commands, SDK, project files, and phase model. The cited workflows coordinate local phase agents; they do not establish persistent Codex child-chat ownership or Linear issue mapping. Background workers are told to decide autonomously, so milestone and decision review policy should be adapted to the user’s desired human gates rather than copied wholesale.

## Recommendation for coordinate-project

Keep the current skill as a lightweight adaptation of these ideas. The current design already covers durable goals, reviewable work units, explicit ownership, dependency evidence, human steering, and optional monitoring. The strongest incremental improvements to consider are:

1. Tie verification receipts to the artifact version or data snapshot/run actually checked. A newer PR head or later data refresh can invalidate an earlier result.
2. Pilot the coordination contract on one representative unit before large or unfamiliar fan-out.
3. Reconcile worker completion reports at safe points, with interval checks as recovery and external-state observation rather than repeated worker nudges.
4. Keep explicit distinctions between delivered work, verified acceptance, and a pending human decision; make review briefs concise and actionable.

Avoid importing a whole framework's tracker, cloud placement, nested coordinator tree, auto-merge/ready policy, or broad cleanup mandate. Preserve the user's existing planning, optional Linear mapping, visible Codex worker chats, meaningful review milestones, and approval boundaries. No upstream prompt text or runtime code was copied into the skill during this investigation.

## Codex ports of pstack

[mdsmithaustin/pstack](https://github.com/mdsmithaustin/pstack) is a CLI-agnostic community port for Codex, Claude Code, Hermes, and Grok Build. Its [README](https://github.com/mdsmithaustin/pstack/blob/main/README.md) documents skills-based installation and its [PORTING.md](https://github.com/mdsmithaustin/pstack/blob/main/PORTING.md) records substitutions and additions. The [pstack-harness adapter](https://github.com/mdsmithaustin/pstack/blob/main/skills/pstack-harness/SKILL.md) explicitly handles Codex `spawn_agent`, model/reasoning selection, agent limits, and scheduling/wakeup fallbacks. Its retained [Orchestrate playbook](https://github.com/mdsmithaustin/pstack/blob/main/skills/poteto-mode/playbooks/orchestrate.md) routes delegation through that adapter, uses a persistent `.orchestrate/<project>/` store, and replaces cloud assumptions with isolated background workers. This is the most directly relevant portable orchestration source among the parent agent's inspected ports. It adds substantial bookkeeping beyond the lightweight skill and still describes internal worker agents/worktrees rather than app-managed visible chats. Source review does not establish that it runs correctly in this session; current tool schemas take precedence over documented runtime assumptions.

[painhardcore/pstack](https://github.com/painhardcore/pstack) is another portable Codex/Claude Code/OpenCode distribution, with Codex plugin packaging and upstream synchronization tooling. Crucially, its [README's omissions section](https://github.com/painhardcore/pstack/blob/master/README.md#what-is-omitted) explicitly removes `orchestrate`, alongside several Cursor-dependent playbooks. It is relevant for portable engineering skills but does not provide the coordinator playbook discussed here.

[tolulawson/pstack](https://github.com/tolulawson/pstack) is a lighter Codex adaptation whose [README](https://github.com/tolulawson/pstack/blob/main/README.md) documents plugin metadata and Codex-oriented substitutions. Its inspected tree lacks the Orchestrate playbook. It also explicitly treats the inherited agent definitions and Benny automation files as reference material rather than native Codex registrations.

[michael-denyer/pstack-claude](https://github.com/michael-denyer/pstack-claude) is a real Codex port, not only a skill bundle with a plugin manifest. Its [README](https://github.com/michael-denyer/pstack-claude/blob/main/README.md) documents Codex marketplace installation, and its [Codex plugin manifest](https://github.com/michael-denyer/pstack-claude/blob/main/plugins/pstack/.codex-plugin/plugin.json) declares shared skills plus a Codex startup hook. More substantively, its [Codex tool mapping](https://github.com/michael-denyer/pstack-claude/blob/main/plugins/pstack/skills/poteto-mode/references/codex-tools.md) maps Claude `Agent` calls to `spawn_agent`, parallel dispatch, wait/close, task tracking to `update_plan`, plain-text user questions, model and reasoning selection, and Codex-specific limits and fallbacks. The docs describe one shared skill tree plus runtime-specific mappings.

The [Orchestrate playbook](https://github.com/michael-denyer/pstack-claude/blob/main/plugins/pstack/skills/poteto-mode/playbooks/orchestrate.md) is present and targets a long-running coordinator session with durable project files, briefs, queued worker reports, dependency relays, a verification ledger, and human gates. Codex adaptation is layered through the tool map: the playbook itself still says `Agent`, `run_in_background`, and `~/.claude/orchestrate/`; the mapping says to use `spawn_agent` (which already continues asynchronously), and the docs say bundled scripts run on Codex. The documented worker model is runtime subagents, not managed, user-visible Codex app chats. That distinction is an inference from the mapped `spawn_agent` interface and the absence of a Codex chat-management workflow in these files.

[chid/pstack](https://github.com/chid/pstack) is a direct GitHub fork of Michael Denyer's repository. It contains the [Orchestrate playbook](https://github.com/chid/pstack/blob/main/plugins/pstack/skills/poteto-mode/playbooks/orchestrate.md), a Codex mapping, and a Codex marketplace manifest, so its files also encode tool-level adaptation. However, its [README](https://github.com/chid/pstack/blob/main/README.md) still tells shared-skill installers to clone `michael-denyer/pstack-claude`, and its [marketplace metadata](https://github.com/chid/pstack/blob/main/.agents/plugins/marketplace.json) retains the `pstack-claude` identity; I found no distinct Codex runtime treatment beyond the copied/adapted tree. GitHub identifies [h00mankind/pstack](https://github.com/h00mankind/pstack) as another fork of Michael's port, adding cross-provider subagents for T3 Code.
