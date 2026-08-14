# ADR-0001: Tiered Patch Capability Contract

- **Status:** Accepted for roadmap
- **Date:** 2026-08-14

## Context

Unrestricted patch effects preserve flexibility but keep the full global state
space and prevent trustworthy locality. Requiring every legacy patch to become
fully compositional at once would block migration.

## Decision

Classify patches as:

- **L:** Local Certified
- **B:** Bounded Shared
- **G:** Global or Legacy
- **U:** Unsupported

L/B may enter the component and certificate fast lane after qualification. G uses
Extended or Global Exhaustive. U is rejected.

## Consequences

- Custom selections can remain available.
- Fast verification is conditional on mechanically bounded effects.
- Legacy migration is gradual.
- A G patch does not prevent unrelated L/B patches from using the fast lane.
- Capability classification and enforcement become product contracts.

## Rejected alternatives

- Unrestricted Global Exhaustive as permanent routine default
- Immediate all-at-once compositional migration
- Preset-only support as the primary plan
