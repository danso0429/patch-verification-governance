# Current Canonical Policy Pointer

## Status

The canonical operational policy is expected at:

```text
docs/patch-combination-verification-instructions.md
```

inside the actual patcher implementation repository.

The public implementation repository is currently unresolved in `TARGETS.yaml`.
Therefore this governance publication does not contain or invent a substitute
canonical policy.

## Current safe interpretation

The reviewed session-local implementation cohort adopted a conservative C0
routing contract. This does not resolve the public implementation target and
does not make this pointer a substitute for the private policy text.

Until the implementation repository and policy file are publicly resolved and
read, the only safe operational interpretation is:

```text
canonical routing contract: conservative global-only C0
current operational gate: Global Exhaustive
current production L/B admissions: zero
current G treatment: blocking Global Exhaustive
unsupported U treatment: reject before mutation
raw-mask reduction: not authorized
component certificates: not authorized
production state migration: not authorized
default verification command change: not authorized
Global Exhaustive fallback removal: not authorized
```

## Required behavior for an LLM

When a task depends on current executable policy:

1. read `TARGETS.yaml`;
2. resolve the implementation repository and exact commit;
3. open the exact canonical policy file;
4. stop if it cannot be opened;
5. do not use this pointer as a replacement for the missing policy text.

## Updating this pointer

After the implementation repository becomes publicly available, update:

- `TARGETS.yaml`;
- `CURRENT-STATUS.yaml`;
- this file with a commit-pinned link;
- the evidence manifest with the policy hash.
