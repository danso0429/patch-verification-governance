# ADR-0002: State Transition Strategy

- **Status:** Accepted for roadmap
- **Date:** 2026-08-14

## Context

One global persisted selection/state stream reconnects all visible packs and
prevents exact component factorization.

## Decision

Use:

```text
S0-P read-only projection
→ S1-D dual-write/dual-read shadow
→ S2 component-local canonical state
```

S0-P and S1-D never issue reusable canonical certificates. S2 is required before
component certificates can replace current persisted-state observations.

## S2 constraints

- component records own local selections, units, files, ownership, ETag, and roots;
- local certificates bind only relevant component and boundary roots;
- global registry changes must not invalidate unrelated local certificates;
- migration, rollback, interruption recovery, installer, and adapter compatibility
  require independent qualification.

## Rejected alternatives

- Permanent S0 global state
- Contract-reducing S1 that simply removes aggregate state bytes from observation
- Direct production migration to S2 without shadow stages
