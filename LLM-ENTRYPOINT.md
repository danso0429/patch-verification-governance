# Patch Verification LLM Entrypoint

## 1. Authority

This repository is the public governance source for the PocketRisu patch-verification
transition.

This entrypoint does **not** authorize code, policy, state, or production changes
by itself.

Before doing any work, read these files completely and in order:

1. `CURRENT-STATUS.yaml`
2. `TARGETS.yaml`
3. The current canonical policy identified by those files

Read the final transition plan when the task:

- changes checker architecture;
- implements, reviews, or advances a transition phase;
- changes state, certificates, capabilities, boundaries, scheduling, or policy;
- disputes a gate result; or
- asks for the rationale behind the current design.

The final plan is:

`docs/plans/PATCH-COMBINATION-VERIFICATION-FINAL-TRANSITION-PLAN.md`

## 2. Required read order by task

### Routine patch checking

1. `CURRENT-STATUS.yaml`
2. `TARGETS.yaml`
3. Current canonical verification policy
4. `docs/runbooks/PATCH-VERIFICATION-OPERATOR-RUNBOOK.md`
5. Relevant implementation source and tests

### Checker architecture or transition work

1. `CURRENT-STATUS.yaml`
2. `TARGETS.yaml`
3. Current canonical verification policy
4. Final transition plan
5. Relevant ADR documents under `decisions/`
6. Relevant implementation source and tests

### Evidence review

1. `CURRENT-STATUS.yaml`
2. `evidence/CURRENT-EVIDENCE-INDEX.md`
3. `evidence/PUBLIC-EVIDENCE-MANIFEST.json`
4. Exact registered evidence files, when available
5. Relevant source and policy at the recorded commits

## 3. Precedence

When sources disagree, use this order:

1. Explicit current user instruction
2. Approved current transition status
3. Current canonical verification policy
4. Current executable source and tests
5. Approved ADR documents
6. Final transition plan
7. Current accepted evidence
8. Historical evidence
9. Model memory, summaries, or inference

Do not treat the transition plan as the current operational policy.

Do not treat a governance document as proof that its implementation already
exists.

## 4. Required report before editing

Before changing anything, report:

- exact governance repository and commit;
- exact implementation repository and commit;
- current transition status version and phase;
- current canonical gate and policy;
- requested task scope;
- every required file successfully read;
- files expected to change;
- prohibited operations;
- required tests and receipts;
- fallback and rollback boundary.

If the implementation repository or canonical policy is unresolved, stop before
source modification and identify the exact unresolved field in `TARGETS.yaml`.

## 5. Fail-closed rules

If a required repository, file, branch, or commit cannot be opened:

- stop the dependent work;
- identify the exact inaccessible resource;
- do not infer its contents;
- do not substitute memory, summaries, filenames, or search snippets;
- continue only independent work that does not need that resource.

If source contradicts documentation:

- preserve both observations;
- report the contradiction;
- do not silently choose the more convenient interpretation.

Do not:

- advance a transition phase automatically;
- change the canonical gate without an approved policy commit;
- skip raw masks unless the active canonical policy authorizes it;
- issue reusable component certificates before the approved certificate phase;
- migrate production state without explicit approval;
- remove the Global Exhaustive fallback;
- convert incomplete evidence into a pass;
- overwrite or delete historical negative evidence;
- treat a prospective dependency-key match as a verified certificate hit;
- assume a boundary snapshot represents every admissible boundary class;
- assume worker order or cache history is irrelevant without proof or isolation.

## 6. Phase control

The active phase and allowed work are defined only by:

`CURRENT-STATUS.yaml`

A phase may advance only after:

1. its completion checklist is satisfied;
2. evidence has been reviewed;
3. the user explicitly approves advancement; and
4. the status file is updated in a separate reviewed commit.

Never update the phase merely because implementation work appears complete.

## 7. Commit pinning

At task start, resolve and record the exact commits used.

Do not switch branches or revisions during the task without reporting the change
and re-establishing the evidence cohort.

For reproducible review, prefer commit-pinned raw URLs rather than mutable
`main` URLs after the task begins.

## 8. Current architectural principle

The current problem is not simply how to schedule 4,096 independent tests.
The current checker reuses worker process, module, cache, root, and unmanaged
history across many masks.

The transition aims to make admitted patch effects explicit, mechanically
bounded, history-safe, locally exhaustive, and certificate-reusable while
retaining a fail-closed Global Exhaustive oracle.

## 9. Completion response

At the end of any task, report:

- exact source and target cohorts;
- changes made;
- tests and receipts;
- correctness result;
- budget result;
- evidence publication status;
- fallback status;
- rollback instructions;
- unresolved blockers;
- proposed status-file update, if any.

Do not apply a proposed status update without explicit user approval.
