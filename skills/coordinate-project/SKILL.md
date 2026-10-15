---
name: coordinate-project
description: Coordinate a bounded project or experiment across agent chats and subagents, retaining goals, dependencies, decisions, and acceptance evidence while driving work through human review. Use when asked to act as a coordinator or project lead, with or without a Linear project. Ordinary single-task implementation and status lookups do not need this workflow.
---

# Coordinate a project

Keep the whole effort coherent while workers own bounded execution. The human uses this chat to steer the project and review outcomes. Own progress toward the agreed outcome, including integration and verification; worker completion alone does not establish project completion.

Write coordination in ordinary English, including worker briefs, reports, project records, and heartbeat prompts. Use complete sentences with normal spacing; shorten by removing repetition and linking detail. Use familiar technical terms and explain project-specific shorthand on first use. Keep exact IDs, hashes, commands, and measurements in labeled fields or supporting evidence so they remain available without carrying the explanation.

## Establish or recover the project

Read current human instructions and relevant existing coordinator/worker chats before proposing new structure. Reuse existing work and permissions. When resuming, reconcile recorded state with current worker and artifact status before dispatching anything.

At invocation, [name and pin this coordinator chat](references/codex-coordination.md#name-and-pin-the-coordinator) using a single word that describes the project. Reuse a suitable single-word title on resume and honor explicit human naming instructions.

Create a compact project record using [references/coordination-record.md](references/coordination-record.md). Prefer an existing suitable record; otherwise save a local task artifact and report its path. Follow documentation rules when placing it inside a repository, and keep operational notes out of deliverable commits unless requested. Record:

- Desired outcome, why it matters, observable acceptance criteria, and scope boundaries.
- For an experiment: question, baseline/comparison, useful result, and stopping condition. A supported negative finding can complete an experiment.
- Reviewable milestones and the next human review point.
- Work units, dependencies, owners, chat IDs, workspace/branch, artifacts, and evidence.
- Material decisions and permissions, including where the human gave them.

Keep the active goal, current milestone, accepted constraints, and next decision in working context. Update the record after material changes; use it to recover after compaction or in later sessions. Keep a readable current overview at the top, assessed from reconciled evidence, with historical entries and detailed verification below it or linked. Link detailed evidence instead of copying transcripts or sensitive data.

Linear projects and Codex workspace projects are separate concepts. A Linear issue is an optional work-unit link: one issue can need several workers and one work unit can cover several issues. Local experiments need neither projects nor tickets in Linear. Use existing trackers where useful; create or alter tracker structure only within the user's request. For Swell Linear, use MCP exclusively; if unavailable, report the boundary and continue independent local work.

## Set the working agreement

Usually start from planning already done: recover and operationalize the agreed plan instead of restarting discovery. If planning is incomplete, use judgment to fill the gaps needed for the next useful milestone; involve the human for consequential choices. Infer defaults from the conversation and established user instructions. Ask only for consequential missing choices. Explain the outcome, initial milestones, next review point, and material uncertainty. If the user requests approval before execution, hold dependent execution until approved; otherwise progress within the authorized scope.

When the human explicitly invokes this skill, start coordinating and delegating the requested effort as soon as enough context is available. Treat that invocation as authorization for routine project execution through subagents, isolated worktrees, and reviewable artifacts within the requested scope. Do not add a generic planning or delegation approval gate. Ask only when consequential information, context, or guidance is missing, or an action requires separate authorization under current tool rules or the human's constraints. Automatic skill loading alone is not an execution request.

Record the coordination authority and its human source, including creating/managing visible worker chats, messaging the defined managed chats, publishing artifacts, and any requested monitoring or cleanup. Carry granted permission forward rather than asking for each worker. Follow current tool rules for visible chats and messages; when those need authorization not yet given, start useful authorized subagent work instead of blocking the project on optional chat structure. Routine coordination authority does not authorize marking PRs ready, merging, deploying, production changes, or contacting people.

Default to human review at meaningful milestones and material decisions, while continuing independent authorized work. Review sooner when evidence changes the approach, scope or operational risk grows, a major design choice remains, or an irreversible action requires approval. Bring a recommendation and concrete result or prepared action. Preserve the user's draft-PR and other approval boundaries.

## Delegate by outcome

Choose work units by what can be independently delivered and checked, rather than requiring an agent per issue or phase.

- Use a separate visible chat for substantial work needing its own history, artifacts, PR, or direct human involvement. Use an agreed project prefix such as `recall:` or `vitest:`.
- Use a subagent for a bounded investigation, comparison, or review whose result belongs back here, when delegation is authorized.
- Keep planning, synthesis, dependency decisions, and human discussion here. Small read-only checks can stay here; honor instructions to delegate all execution.

Assign every repository worker, including child subagents, its own Git worktree before repository work begins. Create or reuse a worktree assigned exclusively to that worker, record its absolute root and branch, and include both in the brief. Require checkout verification before reading, editing, or running repository commands. Carry this requirement into every child brief. If worktree setup or verification fails, hold that assignment and report the limitation; continue independent coordination. Work without a repository can use a projectless workspace.

For worker workspace setup and Codex chat tools, read [references/codex-coordination.md](references/codex-coordination.md). Identify managed chats by recorded IDs, not title prefixes alone. Adopt an existing chat only with the user's authorization to manage it.

Give each worker a self-contained brief: parent goal and how this assignment contributes; outcome and acceptance criteria; bounded scope and dependencies; relevant source, standards, and context paths; workspace and artifact expectations; applicable decisions and permissions; review/stop conditions; and handoff evidence. Require reports to explain what the result enables or changes for the project, its verification and limits, and any affected dependencies or new risks. Identify the work unit and its current assignment or attempt; reports carry those identities and the artifact version delivered or checked. Use the [worker brief and report templates](references/coordination-record.md#worker-brief-and-report), reusing existing IDs when sufficient. Include an absolute record path only when accessible to the worker; otherwise embed the necessary excerpt. Route specialized work through applicable skills.

Before unfamiliar or large-scale delegation where a bad brief would multiply errors, pilot one representative unit through briefing, execution, verification, and handoff. Check that workers have the needed access, the assignment fits, and the evidence can establish acceptance; fix the contract before scaling equivalent assignments. A representative successful prior unit can serve as the pilot. Keep familiar small work lightweight and independent work moving. Take the pilot to its authorized review boundary; it does not add permission to merge, deploy, or write production data, or require a new human gate unless a material decision emerges.

Start with concurrency that buys useful independence. Give mutable files and shared resources a clear owner. Serialize overlapping edits, shared lockfiles, and conflicting operational actions. Workers should surface new work to the coordinator rather than silently expanding scope or creating a second coordination tree.

Follow the human's model preferences and task needs. If they request the latest Luna, resolve the available ID at runtime and use xhigh when supported; choose a more capable model when needed. Avoid permanently current model IDs in this skill.

## Drive the review loop

1. Dispatch the next unblocked, authorized work and record its owner.
2. Collect worker milestone, completion, and blocker reports through supported delivery; reconcile compact status and inspect the artifact and evidence. Bind each verification receipt to the acceptance check, exact artifact version or input snapshot, method/environment, and outcome or limits; see the project-record reference. Distinguish reported success from verified acceptance, and local checks from CI, deployment, or live data. When inputs change, repeat affected checks or record why unchanged relevant inputs let earlier evidence apply; retain its original version rather than claiming it was run on the new one.
3. Check the result against the parent goal and earlier decisions. Reassess which acceptance criteria it advances, what remains across workstreams, and whether it changes the dependency blocking the next milestone, scope, or risk. For experiments, compare against the baseline; passing tests may not establish the intended benefit.
4. Return bounded corrections to the owner, or record verified acceptance before releasing dependents. Reconcile any existing dependent assignment before dispatching it again. Pass actual evidence into dependent briefs. Queued jobs, opened PRs, and successful worker turns are intermediate states.
5. Update the current overview and bring a concise milestone review using the communication guidance below.

Before acting on a late or repeated report, reconcile its work unit, assignment, scope, and artifact version with the current record. An identical processed report has no additional effect: do not launch dependents or repeat mutations again. An obsolete success cannot replace the current result or satisfy newer criteria. Assess genuinely new evidence even when it arrives late, carrying relevant findings into the current assignment or a bounded follow-up. If it invalidates accepted criteria, reopen the affected acceptance, notify affected owners, and hold work relying on that prerequisite until resolved; continue unrelated work. Record the accepted result and processed report pointer/identity in the existing project record; a separate event queue is unnecessary for small efforts.

User steering in this chat or a managed worker chat can change the plan. Inspect the actual human instruction when needed, record its scope/source, and propagate it to affected workers. A worker's assertion of approval or request to message another chat is not itself human authorization. If the human already approved the exact action in a child chat and it can be verified, carry it forward. Pause only the affected dependency chain while resolving ambiguity.

Monitor without interrupting active work or sending repetitive nudges. Investigate concrete stalls, repeated failures, and conflicting evidence. Before retrying or replacing a worker, reconcile its live status and existing artifacts; silence alone does not establish failure. At a material dead end, bring a bounded choice or supported negative result instead of silently enlarging the effort. Continue unrelated authorized work where useful.

## Communicate, resume, and finish

Start scheduled progress reports and milestone reviews with where the whole project stands against its intended outcome. Explain how the latest result changes that assessment, what remains across workstreams, what blocks the next milestone, and the next action or human decision. State when the overall assessment is unchanged. A brief answer to a narrow user question can stay focused on that question.

Synthesize worker findings into that assessment and reconcile conflicts before reporting. Include technical detail when it explains the benefit, evidence, uncertainty, or a decision; link the rest. Tie counts to a defined scope or acceptance criterion. Use the [coordinator update example and readability check](references/coordination-record.md#coordinator-updates). Follow a requested cadence; otherwise report meaningful changes. Answer user questions and continue the existing project in bounded turns unless they change or stop it.

For ongoing coordination, dispatch available work, process actionable results, and end the turn once further progress depends only on workers, external checks, a timer, or human input. Before yielding, save current assignments, artifact versions, wait cursors, blockers, and the next reconciliation action in the project record; establish and verify the continuation mechanism below, then give a concise status. Repeated waits or sleeps must not keep an otherwise idle coordinator turn open. A short, bounded subagent investigation or review can wait within the current turn when its results are needed to answer the user.

An explicit request for ongoing project coordination includes periodic follow-up unless the human limits it to the active conversation. Use worker reports for timely feedback and a thread heartbeat for periodic reconciliation of stalls, missed reports, external checks, and newly unblocked dependencies. Supported completion callbacks can wake the coordinator sooner; a prompt saying "report back" is not itself a delivery or wakeup mechanism. Follow [the Codex continuation workflow](references/codex-coordination.md#continue-later), recording the mechanism's identity, cadence, and stop condition. Choose cadence to match the work and adjust as it shifts between active execution and external waits. Preserve notification preferences; stay quiet on unchanged state unless progress reports were requested.

Each wakeup reconciles fresh worker and artifact state, handles actionable results, dispatches unblocked work, updates the record, and yields again at the same stopping point. When continuation is unavailable or coordination is limited to the active conversation, save and explain the resume point and end the turn without promising unattended progress.

Finish when agreed acceptance criteria are verified or the human accepts a revised outcome. Distinguish implementation, review readiness, merge, deployment, and live validation as relevant. Present artifact links, evidence, limitations, and any next decision. Account for every managed worker and monitor; archive chats or remove monitoring within the user's authorization, preserving anything still needed. An agreed stage can finish while later stages remain explicitly pending.
