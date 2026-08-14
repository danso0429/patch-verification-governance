# ADR-0003: Worker History Policy

- **Status:** Accepted for roadmap
- **Date:** 2026-08-14

## Context

The current checker reuses worker root, process, module graph, caches, and unmanaged
history. Experiments showed that worker partition can change defect detection.

## Decision

The first exact component reference runner uses **H2 fresh-per-local-mask**:

- fresh projected target root;
- fresh process or isolated worker;
- fresh module graph;
- empty caches;
- no prior unmanaged history.

## Optimization path

A persistent/resettable worker may be added only after complete differential
qualification against the H2 reference and explicit reset-failure fallback.

## Consequences

- Per-mask certificates can be history-independent.
- The first implementation may pay higher startup cost.
- Cost must be re-measured on local component widths.
- Schedule alone is not a correctness proof.
