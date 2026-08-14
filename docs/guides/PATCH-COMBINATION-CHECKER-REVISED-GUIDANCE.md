# Patch Combination Checker Revised Guidance

> **Status:** Operational and research guidance. Not current canonical policy.

## 1. Correct mental model

The checker does not create a fresh process for each raw mask. It creates one
complete target copy per worker and reuses that worker's process, module graph,
caches, root, and unmanaged history across many masks.

Managed paths are restored after each mask, but complete worker history is not.
Therefore worker count, ordering, assignment, cache mode, resume order, and retry
history can affect the observation.

“Exhaustive” means every public raw visible-pack mask is executed under the
selected canonical schedule. It does not mean every possible process, cache,
filesystem, platform, crash, or direct-transition history is tested.

## 2. Current route

For each assigned mask:

```text
raw request
→ resolve and initial plan
→ transactional apply
→ status current/clean
→ same-selection zero-change re-plan
→ empty-selection revert plan/apply
→ managed existence/SHA-256/mode restoration
```

Coverage rejects missing, duplicate, and out-of-domain masks.

## 3. What it proves

- public selection reachability
- dependencies, conflicts, supersession, autoWhen
- unit ordering, ownership, anchors, markers, collisions
- transactional apply
- immediate status
- same-selection idempotent planning
- empty-selection revert
- managed path existence/digest/mode restoration

## 4. What it does not prove

- feature intent or UI/mobile behavior
- all target tests/builds for every mask
- runtime/provider/database behavior
- crash recovery and concurrent writers
- arbitrary A→B transitions
- whole-tree, xattr, ACL, ownership, directory metadata identity
- every worker/cache/process history

Structural exhaustive verification remains one gate among tests, build, runtime
audit, manual scenarios, and real-device validation.

## 5. Current measured operating profiles

Historical recheck on Linux arm64, Node v25.9.0, two available CPUs, `/dev/shm`,
4,096 masks:

| Workers | Median wall | Max RSS | Peak temporary storage | Interpretation |
| ---: | ---: | ---: | ---: | --- |
| 1 | 26m 56.8s | about 0.61 GiB | about 187 MiB | constrained profile |
| 2 | 17m 59.6s | about 0.97 GiB | about 368 MiB | balanced profile |
| 3 | 15m 38.5s | about 1.46 GiB | about 549 MiB | fastest measured canonical profile |
| 4 | 16m 39.6s | about 1.71 GiB | about 720 MiB | dominated by jobs=3 on that host |

These are historical host-specific measurements, not universal defaults.

`/dev/shm` is memory-backed; account for process RSS and tmpfs allocation together.

## 6. Experimental balanced scheduling

Balanced scheduling executed every mask and measured materially lower wall time,
but it changed mask order and worker history. A hidden-history mutation showed
that worker partition can affect detection. Therefore it remains experimental
until history is isolated, reset, proven irrelevant, or explicitly adopted as
policy.

A full qualification can cost much more than the per-run saving, so admission
rules must distinguish scheduler/cache/engine changes from ordinary patch payload
changes.

## 7. Cache correctness

A reproduced defect showed that canonicalizing cached result object order changed
persisted JSON bytes. Cache-key canonicalization and observable-result cloning are
different operations.

A cache must preserve every ordering that reaches state bytes, ETags, exported
iteration, ownership, status, replan, or revert. Unsupported or mutable values
must bypass or fail closed. Semantic cache changes require full initial/repeated/
revert differential qualification.

## 8. Why shortcuts failed

### resolvedIds

Same resolved packs can have different explicit/dependency/auto/superseded
provenance and persisted state.

### Initial representatives

Same initial-looking transaction does not prove the same later status, replan,
revert, or history-dependent continuation.

### Gray traversal

It starts from a predecessor rather than pristine state and omits current per-mask
replan/revert/restoration observations.

### Pairwise

Higher-order all/none, adapters, ordering, and global state exceed pairwise scope.

### BDD-only

Compressing an enumerated resolver truth table does not prove apply/status/revert.

### Current components

The global persisted selection state reconnects all visible packs, so exact local
decomposition requires state and access-contract changes.

### Hardlinks

Unsealed write APIs can mutate the shared pristine inode.

### Prospective keys

A dependency-key match is not a stored, integrity-checked complete observation.

## 9. Exactness classes

- **Class 1:** exact under current contract
- **Class 2:** exact only under explicit mechanically enforced assumptions
- **Class 3:** experimental, heuristic, or assumption-unsealed
- **Class 4:** contract-reducing

Every proposed method must state what remains checked per mask, what is reused or
inferred, what is omitted, and what fallback remains.

## 10. Recommended modes

- **Canonical Oracle:** current Global Exhaustive
- **Experimental Balanced Full Route:** all masks but altered history; not canonical
- **Focused Development Gate:** fast local feedback, not final oracle unless policy changes
- **Future Exact Certificate Gate:** seconds-level unchanged/local checks
- **Future Component Proof Gate:** requires capability and state architecture

## 11. Path to seconds

Scheduling cannot turn fresh 4,096-route global proof generation into seconds on
the current limited server. The route is:

```text
seal worker history
→ store complete immutable observations
→ bind every relevant input
→ exact certificate verification
→ rerun only misses or affected closures
→ retain full global fallback
```

Proof verification may be fast; fresh global proof generation may remain slow.

## 12. Evidence rules

- freeze exact source and target cohorts
- pre/post hash direct analyses
- do not accept exit code alone
- separate current/historical/incomplete/invalid evidence
- recompute report statistics from raw receipts
- preserve negative evidence
- do not treat `.git` directory mtime alone as application-tree drift
- classify runtime fields as semantic, compatibility-critical, diagnostic, or informational
- report mechanical closure honestly by domain

## 13. Operational recommendation before transition

- Keep Global Exhaustive as policy oracle.
- Use only a measured canonical resource profile.
- Preserve the cache regression.
- Add heartbeat and compact exact receipts only with cross-validation.
- Keep balanced scheduling experimental.
- Implement Phase 0 before any component, state, or certificate work.
- Never advance phase or change default gate without explicit approval.
