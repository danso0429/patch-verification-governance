# ADR-0004: Global Oracle Boundaries

- **Status:** Accepted for roadmap
- **Date:** 2026-08-14

## Decision

Start in **C0**:

- L/B routine changes: component gate
- G/legacy changes: Extended/Global gate
- core, state, enforcer, certificate, checker, policy: blocking Global Exhaustive
- stable release: blocking Global Exhaustive
- dispute or inconsistent evidence: Global fallback

A future **C1** relaxation requires a separate maturity approval after multiple
releases with zero relevant mismatches, false hits, undeclared accesses, boundary
misses, migration defects, and mutation misses.

## Consequences

- Routine speed can improve without immediately discarding the strongest oracle.
- Release and core changes remain expensive during transition.
- C1 is never automatic.
