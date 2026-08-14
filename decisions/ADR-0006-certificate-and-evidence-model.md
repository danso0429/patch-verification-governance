# ADR-0006: Exact Certificate and Evidence Model

- **Status:** Accepted for roadmap
- **Date:** 2026-08-14

## Decision

Use component manifests with per-mask Merkle leaves, exact retained key bytes,
immutable content-addressed records, atomic publication, fail-closed invalidation,
and a small independent verifier.

A prospective dependency-key match is not a certificate hit.

## Required hit conditions

- exact key reconstruction and byte match;
- source/target/policy compatibility;
- complete component and boundary identity;
- history-isolation validity;
- full local coverage;
- Merkle/content integrity;
- accepted schema and disposition;
- independent verifier success.

Any unknown or mismatch is a miss and concrete rerun.

## Storage

Protect release roots, policy transitions, migrations, failures, and negative
counterexamples. Allow only reference-aware, dry-run, rollback-capable GC.
