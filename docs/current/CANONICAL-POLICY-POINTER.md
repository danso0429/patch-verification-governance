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

Until the implementation repository and policy file are resolved and read:

```text
canonical gate: Global Exhaustive
raw-mask reduction: not authorized
component certificates: not authorized
production state migration: not authorized
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
