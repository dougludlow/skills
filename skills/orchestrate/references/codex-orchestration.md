# Codex orchestration

Use the tools available in the current runtime and their current schemas. Visible worker chats are user-owned; subagents support bounded tasks inside a chat.

## Chat names

Use `🐙 <Project>` for the orchestrator and pin it when authorized. Honor the user's explicit naming choices.

### Worker names

Name worker chats `🐝 <project>: <assignment>`, using the same agreed project name. Apply the prefix once and keep the assignment title through implementation and review corrections.

## Establish identities and authority

Record returned chat IDs and hosts; a title is not an identity or authority to manage a chat.

Record the user's standing authorization for project messages in both directions between the orchestrator and every worker it creates. Carry that grant and its verifiable human source into worker briefs; reuse it for assignments, steering, questions, blockers, and reports without repeated approval. Recover the original human instruction if its source is missing. Keep chat creation, worktree setup, and communication with unrelated chats within their separately applicable tool permissions.

## Create and retain workers

Call `list_projects` before creating a repository chat and use the returned Codex project ID, not a Linear project ID. Use `create_thread` with a worktree target when explicitly authorized. Honor the user's requested starting state and account for uncommitted work; do not assume setup copies it.

Creation is asynchronous. Resolve a queued client ID to a ready chat ID before messaging it, confirm startup with a compact status observation, and record its checkout and branch. Include the required created-thread directive in the user-facing response after creation.

The worker verifies its root, branch, and starting state before editing. Give each writer its own checkout. Pass absolute paths and explicit command working directories to subagents because they inherit the parent directory. Reviewers must see the exact head and any uncommitted patch. Give them an isolated checkout when they execute checks, create repros, or need a stable snapshot while implementation continues.

Keep a PR's owner while the PR is open, including after CI turns green or the user marks it ready. Archive only managed chats whose work is finished and whose lifecycle the user authorized. Keep archived chats archived unless the user requests restoration or continuing that specific owner requires it. Preserve artifacts and unfinished work before any replacement.

## Communicate and observe

For subagents, use native completion delivery and collaboration messages for earlier blockers. For visible chats, use `send_message_to_thread` under the standing project communication grant. The worker reads the grant's human source carried in its brief, and sends directly to its recorded orchestrator; the orchestrator sends directly to its recorded workers. Do not ask for new approval for covered messages. If the tool cannot verify or accept the grant, report that specific blocker and collect available reports through thread status until delivery is restored.

Prefer `wait_threads` with recorded hosts and cursors, using `timeoutMs: 0` for immediate compact snapshots. Use a bounded wait when a near-term result will enable an action. Read bounded chat history only when the report lacks evidence or the user's actual instruction is needed. Inspect current artifacts before accepting a result or replacing a stalled owner. Read back an uncertain mutation before retrying it.

Keep one monitor per PR or live check. The worker owns `babysit`; the orchestrator observes changed outcomes and dependencies. A readiness notification ends that monitoring pass and leaves the worker available for future corrections.

## Continue deliberately

A completed worker turn does not itself prove that an ended orchestrator turn will wake. Verify available continuation behavior. Use an existing active goal or supported callback when appropriate; create goals or schedules only under the current runtime's rules and the user's request. When the runtime requires monitoring in the active task, keep it there.

Record the next observation, action, and stop condition. If no supported continuation is available, save a precise resume point and explain the limitation without promising background execution. When a managed monitor is no longer needed, stop it and verify cleanup. Preserve the PR owner for direct user steering; stopping a monitor does not end ownership.
