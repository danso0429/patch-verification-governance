# ADR-0005: Typed Boundary Contracts and Fallback

- **Status:** Accepted for roadmap
- **Date:** 2026-08-14

## Context

A component checked under one external snapshot is not necessarily valid under
other external selections or states.

## Decision

Every external influence is represented by a typed boundary contract. When the
boundary varies, use one of:

1. component union;
2. exhaustive admissible boundary classes;
3. independent assume/guarantee proof;
4. a narrower typed interface.

Default order:

```text
typed interface → union → enumeration → qualified proof
```

Unknown or unsupported boundaries fail closed to a broader component, Extended
lane, Global Exhaustive, or admission rejection.

## Consequences

- One snapshot never silently represents all external states.
- Component costs include boundary-class multiplicity.
- Boundary schemas and interface versions become certificate inputs.
