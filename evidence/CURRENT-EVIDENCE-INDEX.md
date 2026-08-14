# Current Public Evidence Index

> **Scope:** Sanitized summary of the August 2026 investigation. The original
> source tree and complete receipt set are not yet published here. This index is
> not a substitute for those raw receipts.

## Authority

The investigation was experimental and did not change canonical policy.

Historical source identifiers:

```text
patcher base: 88d882223731352a2889bda5b670b34b11aee208
target:       85a65f3137b45c8de4a8d21a9887be213b1ac3fc
evidence cut: 2026-08-14 KST
```

## Current-source surface observed in the recheck

```text
46 total packs
12 visible packs
34 hidden packs
4,096 raw masks
259 catalog-managed paths
254 active target paths for PocketRisu 1.9.0
1,184 declared units
669 maximum resolved units
```

## Strong findings

### Current checker history model

One target copy/process/module graph/cache set is created per worker, not per mask.
Worker partition and order may affect observed history.

### Canonical resource frontier

Three repeated canonical runs per worker count found:

| Workers | Median wall | Median max RSS KiB | Median peak temp B |
| ---: | ---: | ---: | ---: |
| 1 | 1,616.752 s | 637,048 | 196,206,592 |
| 2 | 1,079.609 s | 1,018,872 | 386,199,552 |
| 3 | 938.538 s | 1,530,060 | 576,020,480 |
| 4 | 999.610 s | 1,795,268 | 754,626,560 |

Jobs=3 was the fastest measured canonical profile on that host; jobs=4 was
resource-dominated by jobs=3.

### Cache byte-order defect

A cached composition clone reordered properties that later reached persisted JSON
bytes. The investigation reproduced the defect and qualified an insertion-order-
preserving experimental fix with a full current-catalog plan differential.

### No proven non-identity exact quotient

Observed partitions such as 2,048 resolved sets and 2,560 state/result classes did
not establish continuation equivalence. Representative controls and mutations
showed that initial equivalence was insufficient.

### Gray traversal

A stronger pristine comparison failed reproducibly at mask 3. Gray remains a
contract-reducing experiment, not an exact replacement.

### Global state obstruction

File/order interaction showed locality, but the global persisted selection/state
stream induced a complete 12-vertex interaction graph. Exact component reduction
requires state partitioning and mechanically enforced locality.

### Balanced scheduling

It measured a substantial wall-time reduction but changed worker history and
therefore remained experimental.

### Mechanical meta-closure

The all-encompassing meta-closure remained incomplete because of provenance-tool
constraints and a substantive Gray failure. Canonical runs, the complete plan
differential, final tests, and target integrity remained independently valid
within their recorded scopes.

## Negative results retained

- resolvedIds deduplication is unsafe
- initial transaction representatives are unproven
- pairwise is insufficient for high-order interactions
- Gray omits current observations and failed stronger qualification
- resolver BDD compression is not an independent transaction proof
- hardlink workers are not fully write-sealed
- prospective incremental keys are not reusable certificates

## Publication limitation

Raw receipts, exact implementation source, canonical policy text, and historical
worktree have not yet been published in this governance branch. Any LLM needing
those materials must stop until `TARGETS.yaml` is resolved or the evidence is
published.
