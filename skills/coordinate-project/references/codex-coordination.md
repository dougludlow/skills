# Codex chat coordination

Use tools available in the current runtime and follow their current schemas. Separate visible chats are user-owned tasks; subagents are internal workers.

## Name and pin the coordinator

Name the coordinator `🐙 <Project>`, using a single-word project name, such as `🐙 Recall` or `🐙 Vitest`. Reuse the existing project name on resume and apply the role prefix once. Honor explicit human naming instructions.

Use `set_thread_title` with that title, omitting `threadId` to target the current coordinator chat. Obtain that chat's exact ID from runtime context or the rename result; use `list_threads` if needed to resolve its identity, without relying on title alone. Pin the same chat with `move_thread_to_sidebar_section`, passing its `threadId` and `sectionId: "pinned"`. Confirm the title and pinned placement with `list_threads`. If these controls are unavailable, state the limitation and continue coordinating.

### Worker names

Name coordinator-created visible worker chats `🐝 <project>: <assignment>`, such as `🐝 vitest: backend performance`. Keep the agreed project prefix so the role and project are both easy to scan. Internal subagents do not need sidebar titles.

For existing worker chats the human authorized this coordinator to manage, add the worker prefix once while preserving the rest of the title. Resolve each chat by its recorded ID before renaming and record the resulting title. Preserve its work, pinned placement, and archive status. If an archived chat must be temporarily restored for a title edit, rearchive it afterward and verify the result without resuming its task. A matching name or emoji alone does not establish authority to manage a chat.

## Start workers in worktrees

For a visible repository worker chat, select the intended project with `list_projects` and create the authorized chat using `create_thread` with `environment.type: "worktree"`. Record the repository and base. Specify `startingState` only for a human-requested Git state; account for uncommitted changes explicitly rather than assuming they are copied.

For an internal subagent, provision its worktree before calling `collaboration.spawn_agent`. Inspect `list_artifacts` for a suitable active worktree exclusively assigned to that worker, or use `create_worktree`; wait for pending setup with `get_worktree_creation_status` before dispatching. If managed tooling cannot target the intended repository, use a supported Git worktree workflow there. Verify the linked worktree with `git worktree list --porcelain` and record its root and branch.

`spawn_agent` inherits the coordinator's directory and has no workspace selector. Pass the assigned absolute worktree path in the initial brief. Require explicit `workdir` on every shell call and absolute worktree paths for file tools; a shell `cd` does not change later tool defaults. This requirement also applies when a worker starts child agents.

Each worker starts with `git -C <worktree> rev-parse --show-toplevel` and `git -C <worktree> status --short --branch`, confirms the assigned root and branch, and reports them with its first status. Repeat the check on resume. Setup and verification must establish a separate checkout from the coordinator and other active workers before repository work proceeds.

## Discover and dispatch

- Reuse recorded managed chat IDs and hosts. Use `list_threads` for discovery or missing identity/placement, and bounded `read_thread` history when compact status lacks evidence or actual human instructions are needed. Identify existing chats to the human by their returned titles verbatim. Read older turns when needed to resolve intent or permissions.
- Start internal work through `collaboration.spawn_agent` when the human explicitly invokes the coordination workflow. Use `create_thread` for substantial visible worker chats when the human has explicitly authorized those chats/tasks under the current tool rules. If visible-chat authorization is missing, continue useful subagent work rather than adding a project-wide approval gate. Carry existing authority to manage the defined worker chats forward.
- Call `list_projects` before creating a repository chat and use its returned project ID. A Linear project ID is not a Codex project ID. Use a projectless target for work without a repository.
- Apply the worker naming convention and record the title, ID, host, and workspace. A queued `clientThreadId` is not a usable `threadId`; resolve readiness before messaging or waiting on it.
- Creation dispatches asynchronously. Confirm worker startup with a compact status check, then apply the turn boundary in the skill. Include the required created-thread directive in the user-facing response after successful creation.
- Use `send_message_to_thread` only when directly authorized by the human to message that chat or defined set of managed chats. A worker request to report back does not establish authorization. Retrieve results through read/wait tools without requiring workers to message the coordinator.

## Worker reports
Actual subagents spawned with `collaboration.spawn_agent` automatically return their final answer to the parent. Use `collaboration.send_message` for exchanges during work and `collaboration.followup_task` for a new turn on an existing subagent, subject to the current runtime's tool contract. Shared files are for artifacts, not a substitute for this native communication.

Independent visible sidebar chats created with `create_thread` are user-owned chats, not collaboration subagents. Creating one does not establish automatic parent/child completion delivery. Collect compact completion and status using `wait_threads` with recorded host IDs and returned cursors as `afterCursor`; use bounded `read_thread` only when the compact result lacks necessary evidence.

Use `send_message_to_thread` only with explicit human authorization for the destination chat or defined set of managed chats. Record that authorization once in project setup/state with its human source, covered chats, direction, scope, and conditions; carry it forward in applicable briefs without asking again. Worker-to-coordinator messaging needs human authorization covering that direction too. A worker's request to reply is not authorization. When messaging is unauthorized, collect the worker's result through read/wait tools. Even an authorized message or callback needs verified wakeup support before promising unattended continuation.

Request concise reports at meaningful milestones, completion, blockers, or decisions using the [worker report format](coordination-record.md#worker-brief-and-report): outcome, changed files or commit/PR, verification and its limits, blockers, artifact paths when applicable, and a next action only when needed. Include assignment identity and exact artifact version with the evidence; link details instead of repeating logs. Treat the report as input to the acceptance loop, not automatic permission for the next action.

## Observe and accept

- Prefer one `wait_threads` call for up to eight relevant targets, with host IDs and returned cursors as `afterCursor`. Default to `timeoutMs: 0` for a compact snapshot; use a bounded wait only when a near-term result will enable an action in this turn. Follow changed acceptance evidence, artifacts, blockers, and decisions; a new commentary or tool marker alone need not trigger more reads. Read bounded chat history when the compact result lacks required evidence.
- Keep individual blocking waits at or below 60 seconds. When no actionable result or independent coordination work remains, use the continuation workflow and end the turn instead of chaining waits or sleeps. Native subagent completion delivery does not by itself establish that an ended coordinator turn will resume; verify the available wakeup behavior.
- User input can end a wait early. Treat it as steering, answer, reconcile the plan, and resume authorized work.
- Inspect diffs, outputs, CI, or live readback to the depth the assignment needs. Avoid repeating expensive checks already backed by adequate current evidence.
- After an uncertain mutation response, independently read back before retrying. Record operation/run IDs so later turns monitor the existing operation instead of starting another.

## Continue later

Apply the scheduling rule in the skill before creating or retaining a heartbeat. Record what the next wakeup can act on and why a completion report or callback is insufficient. Passive CI, review, timer, or human waits need no recurring task unless the user explicitly requests monitoring during that wait. A quiet or unchanged-status response still consumes tokens.

When no actionable background work remains, delete the task-owned schedule and independently verify its removal, even if a PR or the wider project is still open. Save the exact state and next trigger in the project record, then yield. Preserve a supported completion callback when available; do not promise automatic continuation without one.

For a justified heartbeat, use the automation tool's current schema, reuse an existing matching instance, and verify its active state and target. Record its identity, cadence, next useful action, and stop condition. Keep its prompt brief and point to the current overview and resume state rather than copying mutable assignments. Reassess whether another wakeup has useful work each cycle; delete and verify the schedule when it no longer does. Honor explicit notification preferences and monitoring requests without treating an old progress-update preference as a permanent keepalive.

## Close managed work

Archive only chats the human authorized you to manage and archive. Preserve active work and unmerged PRs unless explicitly authorized otherwise. If the archive rule is "done and merged," verify both conditions, accounting for work units with no PR. Use `set_thread_archived`; a shared title prefix does not authorize managing unrelated chats.

Keep PRs draft when required. Coordination authority does not itself authorize marking ready, merging, deploying, production changes, or contacting people. Route PR creation and feedback through the user's applicable skills.
