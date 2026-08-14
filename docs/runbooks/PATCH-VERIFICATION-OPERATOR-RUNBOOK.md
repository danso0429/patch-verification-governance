# Patch Verification Operator Runbook

> Commands are templates. Confirm the actual implementation repository,
> `package.json`, scripts, canonical policy, target path, and current status before
> running them.

## 1. Bootstrap

1. Read `LLM-ENTRYPOINT.md`.
2. Read `CURRENT-STATUS.yaml`.
3. Read `TARGETS.yaml`.
4. Resolve the actual implementation repository and exact commit.
5. Read the canonical policy.
6. Report scope, prohibitions, tests, fallback, and rollback before editing.

Stop source-dependent work while `TARGETS.yaml` marks the implementation repository
unresolved.

## 2. Evidence cohort

Record:

```text
governance repository/commit
implementation repository/commit
working-tree status and diff hash
canonical policy hash
target repository/commit/status
Node/platform/filesystem/umask
worker count and schedule
cache/history mode
pre-run source and target roots
```

Do not change revisions mid-task without creating a new cohort.

## 3. Historical canonical preflight template

Only use after confirming these commands exist in current source.

```bash
git --no-pager status --short --branch
git --no-pager -C /path/to/pristine/PocketRisu rev-parse HEAD
git --no-pager -C /path/to/pristine/PocketRisu status --short

test ! -e \
  /path/to/pristine/PocketRisu/save/pocketrisu-patches/state.json

du -sk /path/to/pristine/PocketRisu
df -Pk /dev/shm
free -k
npm test
```

## 4. Historical Global Exhaustive command template

```bash
TMPDIR=/dev/shm npm run verify:combinations -- \
  --root /path/to/pristine/PocketRisu \
  --jobs N \
  --json
```

Historical resource profiles:

```text
jobs=1: constrained memory/tmpfs
jobs=2: balanced
jobs=3: fastest measured canonical on the audited host
jobs=4: not default on that host
```

Do not encode these as universal defaults. Re-measure current source and host.

## 5. Acceptance checks

A run is successful only when:

- process started without spawn error;
- exit code is zero and no signal occurred;
- required output exists and parses;
- reported failure count is zero;
- raw-mask coverage is exact;
- target status remains clean;
- residual state, intent, journal, transaction, and lock artifacts satisfy policy;
- receipt integrity verifies;
- source and target cohorts match.

## 6. Failure handling

On first failure:

1. preserve stdout, stderr, receipt, mask, phase, worker, ordered worker history;
2. inspect target integrity immediately;
3. do not reschedule or retry before preserving evidence;
4. reproduce under canonical stride;
5. disable caches where relevant;
6. use fresh isolation where history is suspected;
7. minimize into a regression;
8. classify patch/checker/cache/scheduler/harness/environment/target/policy cause;
9. retain the original negative evidence after a fix.

## 7. Current phase guard

Current status records Phase 3B as completed and authorizes a read-only Phase 4
entry audit only. It does not authorize Phase 4 implementation.

Allowed categories:

- audit the current global-state schema and serializers
- design isolated S1-D shadow records and dual-read comparison
- design ETag, status, re-plan, revert, journal and recovery comparison
- design exact rollback without touching production user data
- prepare the exact Phase 4 implementation scope, tests and rollback boundaries

Forbidden:

- reducing raw-mask domain
- implementing Phase 4 without separate user approval
- issuing reusable certificates or skipping canonical executions
- modifying selection, planning, apply, status, revert or persisted state
- component certificate publication
- production state migration
- default gate change
- Global Exhaustive removal
- beginning Phase 5
- phase advancement without approval

## 8. Completion report

Report separately:

```text
correctness: passed | failed | incomplete
budget: passed | exceeded | unknown
evidence: publishable | non-publishable
fallbackRequired: true | false
```

Include changed files, tests, receipts, rollback, blockers, and a proposed—but not
applied—status update.
