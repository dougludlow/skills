---
name: verify
description: Establish whether a delivered change meets its acceptance criteria using evidence from the actual artifact and identified version. Use to verify implementation, independently check a worker handoff, or refresh behavioral evidence after changes. CI monitoring belongs to babysit and documented-rule review to check-compliance.
metadata:
  inspired-by: https://github.com/cursor/plugins/blob/35a90942a7f02e1ebbc2443643179815f2147954/pstack/skills/create-verification-skill/SKILL.md
---

# Verify

Read and apply the shared [non-negotiables](../implement/references/non-negotiables.md) within this verification's scope and permissions.

Establish the requested outcome from observable evidence. Verification evaluates the result; implement fixes only when separately authorized. Honor read-only restrictions, use isolated test data and instances, and keep external side effects within the task's existing permissions.

## Identify the claim and version

Resolve the acceptance criteria from the user's request, assignment, and current authoritative plan. Name the behavior or artifact each criterion requires. Inspect the actual change and relevant callers so a report cannot silently redefine what was requested.

Identify the inputs being verified: repository and actual PR base/head, any staged, unstaged, or relevant untracked snapshot, and the applicable requirements revision. Use artifact versions or content hashes for non-code outputs. Establish a stable snapshot when another agent is editing. If the requested version is unavailable or changes during the check, report that limit and reconcile the version before accepting the result.

## Choose proportionate evidence

Discover applicable repository checks and any project-specific verification skill or harness. Reuse their documented launch, setup, drive, and cleanup instructions. Match each acceptance criterion to a concrete action and observable pass condition, including important failure cases and side effects.

- Run the repository-required checks for the change. Evaluate whether their assertions actually cover the affected behavior; successful execution alone does not establish coverage.
- Exercise the relevant real boundary: a UI interaction and resulting state, a CLI invocation and output, an API request and side effect, or a library's public interface. An existing automated test can supply this evidence when it exercises that behavior faithfully.
- For documents, inspect the actual deliverable. For skills and agent workflows, use a realistic bounded task when practical and inspect the agent's actions and result; frontmatter validation does not establish behavioral quality.
- Measure performance when a requirement, changed execution path, or repository rule makes it material. State the baseline, method, and criterion before interpreting the result. Avoid universal UI, live-environment, or performance gates for unrelated changes.

Use the narrowest method that establishes the claim. A compiler result, mocked internal call, screenshot alone, or worker self-report may support a check without proving the requested behavior. When a required environment or permission is missing, mark the affected criterion unverified and explain what observation would close it. Do not substitute a different outcome or weaken the check.

If a harness is missing, prefer a small isolated probe using the repository's existing tools. Add a reusable verification script or project-specific skill only when requested or when it is justified within the authorized implementation scope. Validate any new procedure by running it. Preserve evidence while cleaning up only processes and scratch state created for the check.

## Check findings and freshness

For a suspected failure, record the action or exact command, observed result, expected result, and relevant code or artifact location. Reproduce it independently when evaluating someone else's runtime claim. Compare against the base when needed to distinguish an introduced regression from an existing failure. An existing failure can still leave an acceptance criterion unverified; state both facts.

Evidence applies to its recorded inputs. After a fix, rebase, changed dependency, or requirement change, inspect what changed and rerun affected checks. Matching patch IDs alone do not prove unchanged behavior on a different base. Preserve earlier evidence at its original version and explain any justified reuse. Each new PR head needs its own applicable CI results, even when some behavioral evidence remains valid.

## Return the evidence

Return a compact assessment with enough detail to inspect or repeat each check:

| Acceptance criterion | Version / environment | Method | Observed result / evidence | Outcome |
| --- | --- | --- | --- | --- |

Use passed, failed, or unverified per criterion. Name who performed independent checks, distinguish them from author checks and CI, and include material coverage limits. Start with failures or gaps when present. Conclude that the requested scope is verified only when every required criterion has adequate evidence. A verification pass does not mark a PR ready, approve a merge, or establish deployment.
