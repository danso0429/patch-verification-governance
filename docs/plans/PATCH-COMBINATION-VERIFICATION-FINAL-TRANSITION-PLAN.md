# Patch Combination Verification 최종 전환 계획

> **상태:** 최종 설계 및 구현 계획
>
> 이 문서는 채택할 장기 아키텍처와 단계별 전환 조건을 확정한다.
>
> 이 문서 자체는 현재 checker, 운용 정책, 사용자 지원 계약 또는
> persisted-state 형식을 변경하지 않는다.
>
> qualification과 명시적인 정책 승인 전까지 Global Exhaustive가 canonical
> structural oracle이다.

## 1. 최종 결정 요약

장기 아키텍처는 다음 구조로 전환한다.

```text
tiered patch capability contract
    + hermetic effect/action model
    + executable effect manifest
    + deny-by-default capability enforcement
    + mechanically derived interaction hypergraph
    + typed boundary contracts
    + fresh-isolated affected-component exhaustive verification
    + component-local persisted state
    + immutable exact Merkle certificates
    + independent certificate verifier
    + fail-closed Global Exhaustive fallback
```

이 계획은 기존 Global Exhaustive의 일부 mask를 임의로 빼는 계획이 아니다.
Patch effect의 자유도를 선언·제한·강제하여 더 작은 검증 단위가 충분한 증거가
되도록 제품 구조를 바꾸는 계획이다.

## 2. Decision Record

### 2.1 D1 — Tiered Capability Contract

모든 patch는 네 등급 중 하나로 분류한다.

| 등급 | 이름 | 의미 |
| --- | --- | --- |
| L | Local Certified | 독립 owned files 또는 봉인된 local regions/state만 사용 |
| B | Bounded Shared | 명시된 shared regions, symbols, ordering, typed boundaries만 사용 |
| G | Global or Legacy | global state, global hotspot, arbitrary code 또는 봉인되지 않은 effect 사용 |
| U | Unsupported | effect를 기계적으로 관찰·제한할 수 없거나 계약을 위반 |

운용:

```text
L/B:
    Component Gate와 exact certificate 후보

G:
    Extended 또는 Global Exhaustive

U:
    admission 거부
```

Custom selection은 가능한 범위에서 유지하지만, fast lane은 검증 가능한 effect
계약을 지키는 patch에만 제공한다.

### 2.2 D2 — State: S0-P → S1-D → S2

```text
S0:
    현재 global state와 Global Exhaustive fallback

S0-P:
    read-only component projection
    contract 변화 없음
    certificate skip 없음

S1-D:
    global canonical state + shadow component records dual-write/dual-read
    reusable canonical certificate 없음

S2:
    component-local state가 canonical
    global compatibility view는 derived projection
```

Aggregate state byte observation을 제거하는 축소형 S1 contract는 canonical
후보로 채택하지 않는다.

### 2.3 D3 — C0 → C1 단계형 혼합 운용

C0 전환기:

```text
routine L/B patch:
    60초 Component Gate

G patch:
    Extended Gate

core/state/checker/enforcer/certificate/policy 변경:
    blocking Global Exhaustive

stable release:
    blocking Global Exhaustive
```

C1은 여러 release 동안 mismatch, false hit, undeclared access, migration defect와
mutation miss가 0인 경우 별도 승인으로만 검토한다.

### 2.4 D4 — 다차원 Admission Envelope

Visible width `k` 하나만으로 비용을 결정하지 않는다.

```text
k = local visible pack count
b = admissible boundary class count
w = treewidth 또는 verified support width
u = resolved unit count
p = managed path/region count
d = changed byte volume
o = ordering/collision/precondition complexity
h = fresh isolation/reset overhead
c = certificate/state aggregation overhead
v = measured variance
```

초기 규칙:

```text
k <= 6:
    보수적 shadow 범위

k <= 7:
    실측 뒤 soft target 후보

hard admission:
    calibrated p95 upper bound × safety factor <= 60 seconds
```

Budget 초과는 correctness failure와 분리한다.

### 2.5 D5 — Global Oracle 보존

Global Exhaustive는 다음에서 보존한다.

- component checker qualification
- resolver/catalog loader
- compose/manager/status/transaction/revert
- state schema/migration
- effect enforcer/hypergraph compiler
- certificate verifier/store
- scheduler/history model
- canonical policy
- G patch admission
- C0 stable release
- inconsistent evidence
- dispute/fallback
- periodic audit

### 2.6 D6 — Worker History: H2 Fresh Per Local Mask

첫 exact component checker는 각 local mask마다 다음을 새로 만든다.

```text
fresh projected target root
fresh process or worker
fresh module graph
empty calculation cache
empty unmanaged history
```

Persistent/resettable worker는 H2 reference와 complete differential을 통과한 뒤에만
후속 최적화로 허용한다.

### 2.7 D7 — Typed Boundary Contract

외부 boundary가 다른 component selection에 따라 달라질 때 다음 중 하나를
수행한다.

1. components를 합친다.
2. 모든 admissible boundary class를 실행한다.
3. independent assume/guarantee proof로 equivalence를 증명한다.
4. typed interface로 허용 값을 제한한다.

기본 우선순위:

```text
typed contract
    → component union
    → boundary-class enumeration
    → qualified assume/guarantee proof
```

단일 snapshot은 그 snapshot 하나만 증명한다.

### 2.8 D8 — Effect Enforcement

기존 patch:

```text
executable manifest + capability-wrapped execution
```

새 patch:

```text
declarative effect/action IR 우선
```

봉인할 수 없는 arbitrary execution은 G 또는 U다. Trace-only는 완전성 증명이
아니다.

### 2.9 D9 — Verification Algorithm

첫 canonical 후보:

```text
affected component
× every admissible boundary class
× every local raw mask
× fresh-isolated full local route
```

후속 후보:

- tree-decomposition verification
- separator dynamic programming
- critical-pair/confluence proof
- symbolic resolver proof
- proof-carrying declarative actions
- immutable functional patch engine

후속 알고리즘은 component exhaustive reference와 독립 qualification을 통과해야
한다.

### 2.10 D10 — Certificate Granularity

```text
component certificate manifest
    ├── component identity and schema
    ├── boundary contract root
    ├── component state root
    ├── per-mask observation Merkle leaves
    ├── exact local coverage bitset
    ├── source/target/policy roots
    └── disposition/failure metadata
```

Digest는 index일 뿐이며 bucket 내부 exact retained-key bytes를 비교한다.

### 2.11 D11 — Evidence Storage

- immutable content-addressed blobs
- small manifests
- protected failures/counterexamples
- release/policy/migration roots 장기 보존
- successful bulky traces는 승인된 retention 대상
- GC는 dry-run, reference validation, protected dispositions와 rollback manifest 필요

### 2.12 D12 — Independent Certificate Verifier

Generator와 별도인 작은 read-only verifier가 다음을 검사한다.

- strict schema/version
- exact retained key
- Merkle/content integrity
- coverage
- source/target/policy compatibility
- boundary proof
- disposition
- completeness
- corruption/truncation/stale registry

### 2.13 D13 — Gradual Legacy Migration

현재 모든 pack을 한 번에 L/B로 전환하지 않는다.

```text
L candidate
B candidate
G legacy/global
U unknown/unsupported
```

가장 독립적인 L candidate부터 migration하고 실제 비용과 defect yield를 측정한다.

## 3. 목표와 비목표

### 목표

- Custom selection을 가능한 범위에서 유지한다.
- L/B routine gate를 60초 이내로 제한한다.
- 비용을 전체 visible count가 아니라 실제 interaction closure에 연결한다.
- 모든 admitted effect를 기계적으로 제한한다.
- 고차 interaction을 hypergraph로 보존한다.
- Component 내부 local masks를 전수 concrete 실행한다.
- Worker history를 fresh isolation으로 제거한다.
- Unchanged complete evidence만 exact certificate로 재사용한다.
- Unknown은 broader component, Extended 또는 Global fallback으로 처리한다.
- Checker, certificate와 report pipeline 자체도 검증한다.

### 비목표

- 입력 크기와 무관한 상수 시간이라고 주장하지 않는다.
- Arbitrary global freedom과 60초 budget을 동시에 무제한 보장하지 않는다.
- Pairwise, sampling, representatives 또는 resolver-only BDD를 exact 대체로 쓰지 않는다.
- Structural gate를 tests/build/runtime/UI/device validation의 대체로 쓰지 않는다.
- Budget을 맞추기 위해 failure나 slow mask를 생략하지 않는다.
- Shadow state나 prospective keys를 canonical evidence로 쓰지 않는다.

## 4. 현재 출발점

Historical recheck surface:

| 항목 | 값 |
| --- | ---: |
| Total packs | 46 |
| Visible selectable packs | 12 |
| Hidden packs | 34 |
| Raw masks | 4,096 |
| Catalog-managed paths | 259 |
| Active 1.9 paths | 254 |
| Declared units | 1,184 |
| Maximum resolved units | 669 |

새 source cohort마다 다시 측정한다.

Current checker는 worker마다 target copy, process, module graph, caches와 unmanaged
history를 재사용한다. 따라서 worker count와 schedule은 단순 성능 옵션이 아니라
execution context다.

현재 비자명한 exact quotient는 증명되지 않았다.

## 5. Threat Model

보호할 오류:

- mask missing/duplicate/out-of-range
- dependency/conflict/supersession/autoWhen 오류
- hidden activation
- region/file/symbol/state interaction 누락
- ownership/order/precondition drift
- apply/status/replan/revert 오류
- cache/property-order divergence
- worker-history divergence
- undeclared access
- source/target drift
- stale/corrupt certificate
- migration/recovery failure
- timeout false success
- receipt/report false pass

Unknown, unsupported 또는 inconsistent condition은 certificate를 발행하지 않는다.

## 6. Architecture

```text
source/target/policy freeze
    ↓
manifest/action compilation
    ↓
capability validation and enforcement
    ↓
action graph and interaction hypergraph
    ↓
affected component and boundary closure
    ↓
cost preflight
    ↓
independent certificate lookup/validation
    ↓
exact hit or fresh local execution
    ↓
certificate construction and atomic publication
    ↓
registry update
    ↓
cleanup and integrity validation
```

Component membership은 사람이 적은 이름이 아니라 actual actions, capabilities,
reads/writes/state/symbols, selection relations, boundaries, ownership, ordering와
transaction coupling에서 파생한다.

## 7. Executable Manifest and Action Model

Manifest는 다음을 versioned하게 선언한다.

- capability class
- target versions
- visible/hidden selection support
- actions
- file/region/state/symbol reads and writes
- ownership
- boundaries
- requires/conflicts/supersedes/autoWhen
- before/after order
- preconditions

L/B lane에서 arbitrary filesystem, network, clock/random planning, child process,
dynamic code, native addon, undeclared environment, process-global mutable state와
unwrapped descriptors는 금지한다. 봉인할 수 없으면 G/U다.

새 patch는 create-owned-file, replace-region, insert-anchor, register-symbol,
write-component-state와 같은 declarative IR operation을 우선 사용한다.

## 8. Boundary Contract

Boundary는 외부에서 들어오지만 local observation에 영향을 주는 모든 값이다.

예:

- target version
- registry/API interface
- external component state root
- shared region baseline
- ordering predecessor result
- ownership authority
- target adapter output
- transaction coordinator version

서로 다른 external state가 같은 observation을 준다는 proof가 없으면 다른
boundary class다.

## 9. Compositional Admission Theorem

Global selection의 component composition을 exact evidence로 인정하려면 다음을
모두 만족해야 한다.

1. Resolver가 global request를 deterministic local selections로 분해한다.
2. 모든 effect가 manifest/action model에 포함된다.
3. Actual access가 capability enforcer로 제한·기록된다.
4. Undeclared cross-component dependency가 없다.
5. 모든 varying boundary가 union, enumeration 또는 independent proof로 처리된다.
6. 각 local selection이 exact boundary 아래 complete certificate를 가진다.
7. Cross-component writes가 disjoint하거나 deterministic order를 가진다.
8. State/status/transaction/revert composition이 deterministic하고 atomic하다.
9. IDs, membership, interfaces와 schemas가 versioned다.
10. Missing premise는 fallback이지 success가 아니다.

## 10. State Migration

### S0-P

Current global state에서 read-only projections를 만든다. Contract 변화, skip,
certificate publication이 없다.

### S1-D

Global state를 canonical로 유지하면서 shadow component records를 dual-write한다.
Selection, units, files, ownership, ETag, status, replan, revert와 recovery를
비교한다. Reusable certificate는 없다.

### S2

Component-local records가 canonical이 된다. Local certificate는 own component
root와 실제 boundary roots만 bind한다. Global registry root 변경이 unrelated
local certificate를 무효화하지 않아야 한다.

Migration은 dry-run, backup, old→new, new→old rollback, interruption recovery,
installer/adapter compatibility와 multi-component atomicity qualification이 필요하다.

## 11. Local Verification

Domain:

```text
BoundaryClasses(C) × {0,1}^LocalVisiblePacks(C)
```

각 case는 fresh root/process/module/cache/history에서 다음을 실행한다.

1. exact boundary 로드
2. local resolve/initial plan
3. preconditions
4. transactional apply
5. expected status
6. same-selection zero-change replan
7. local/component revert
8. managed/state/artifact restoration
9. boundary-owned surface invariance
10. root/process disposal

Coverage는 missing, duplicate, out-of-range masks와 boundary classes를 거부한다.

## 12. Certificate Architecture

Key는 contract/policy, schemas, membership, bit order, masks, boundary classes,
source, actions, engine hashes, target baseline, state roots, capabilities, access
trace, semantic environment와 history policy를 bind한다.

Value는 complete coverage, per-mask plan/apply/status/replan/revert/restoration,
boundary, provenance, resources와 failure metadata를 포함한다.

Publication:

1. unique temp record
2. complete hash verification
3. independent verifier
4. durability flush policy
5. atomic rename
6. atomic registry update
7. registry root verification

Any mismatch is a miss and concrete rerun.

## 13. Cost and Admission

```text
T(change) =
    cohort freeze
  + manifest/graph delta
  + certificate verification
  + Σ affected component:
        boundary classes
        × local masks
        × calibrated route cost
  + state aggregation
  + publication
  + cleanup
```

Admission uses measured p95 upper bound and safety factor. Results have separate
axes:

```text
correctness: passed | failed | incomplete
budget: passed | exceeded | unknown
evidence: publishable | non-publishable
```

Timeout never creates partial success or a certificate.

## 14. Verification Lanes

- **Local:** L/B, ≤60s, fresh local exhaustive, exact certificate
- **Extended:** G, over-budget, wide boundaries, broader/global execution
- **Core:** engine/state/enforcer/certificate/checker changes
- **Audit:** periodic oracle and drift checks
- **Emergency:** explicit reduced gate with mandatory later oracle

## 15. Global Oracle Matrix

C0 retains blocking Global Exhaustive for core, state, enforcer, certificate,
scheduler/history, policy, G patch, stable release, dispute and inconsistent evidence.

C1 relaxation requires a separate maturity approval. There is no automatic C1
transition.

## 16. Engine Qualification

Resolver:

- small known-answer catalogs
- relation cycles and invalid schemas
- high-order all/none
- bit/catalog order determinism
- independent formula evaluator

Compose/ownership:

- disjoint commutativity
- ordered shared writes
- conflicts and ownership
- anchors/markers/symbols
- cache byte-order exactness
- unsupported values

Transaction/status/revert:

- failure injection
- journal/lock interruption
- status drift
- idempotency
- exact local revert
- corrupt state
- atomic multi-component recovery

Enforcer:

- every bypass surface is caught or disqualifies L/B admission.

## 17. Transition Phases

### Phase 0 — Current correctness and oracle freeze

- isolate cache correctness fix
- preserve focused regression
- document worker history
- freeze source/target/policy/catalog evidence
- separate evidence dispositions
- fix target identity handling
- classify runtime-envelope fields
- retain independent Global Exhaustive fallback

No component checker, state migration, certificate reuse, mask skipping, default
change or production target modification.

### Phase 1 — Inventory and classification

- manifest schema/compiler
- complete pack/unit/path/region/state/symbol inventory
- L/B/G/U classification
- human-readable catalog generation
- S0-P projection

### Phase 2 — Capability engine and hypergraph

- deny-by-default capability API
- legacy wrapper
- action IR
- actual access enforcement
- high-order hypergraph
- typed boundaries

### Phase 3A — Fresh S0-P shadow verifier

- fresh local route
- all boundary classes and local masks
- exact coverage
- no skip or certificate publication
- shadow comparison with Global Exhaustive

### Phase 3B — Composition theorem qualification

- boundary union/enumeration/proof
- write/order/ownership/status/revert composition
- split/merge rules
- theorem premise checker

### Phase 4 — S1-D dual-write shadow

- global canonical + component shadow
- semantic comparison
- ETag/status/replan/revert/recovery

### Phase 5 — S2 component-local state

- component records and registry
- partial Merkle proofs
- migration/rollback/recovery
- compatibility

### Phase 6 — Certificate store and verifier

- exact schema
- atomic immutable store
- Merkle leaves
- independent verifier
- registry, retention and GC

### Phase 7 — Long shadow qualification

- old/new differential
- real admissions
- adversarial/mutation tests
- false-hit and unknown-interaction checks
- p95/p99 budget calibration

### Phase 8 — C0 policy switch

- L/B/G/U contract approval
- Local/Extended/Core/Audit CLI
- explicit fallback
- canonical policy update
- rollback validation

### Phase 9 — C1 maturity review

- multiple stable releases
- mismatch/false-hit/undeclared-access/boundary/migration/mutation failures all zero
- cost/storage/defect-yield review
- separate approval

## 18. Mandatory Adversarial Matrix

Must include:

- independent patches
- disjoint and conflicting same-file regions
- symbol dependencies
- three-way autoWhen
- hidden multi-parent child
- component bridge/union
- varying boundary classes
- undeclared access
- cache order mutation
- worker hidden state
- target byte/mode/symlink drift
- unrelated component stability
- split/merge invalidation
- engine hash change
- corrupt/truncated/stale certificate
- interrupted atomic publication
- apply/revert crash
- budget overrun
- report false pass

## 19. Evidence and Provenance

Every run binds source, target, policy, schemas, environment, command, coverage,
results, resource metrics and receipt integrity.

Exit code zero is insufficient without no spawn error, non-empty required output,
parse success, zero failures, complete coverage, target integrity and receipt
integrity.

Current, defect-reproduction, historical, incomplete, invalid, superseded and
diagnostic evidence are separate dispositions.

## 20. Storage and GC

Use content-addressed blobs, immutable manifests, protected failure evidence and
reference-aware GC. GC requires dry-run, protected-disposition exclusion, approved
hash list, atomic registry update, post-GC verification and rollback manifest.

## 21. Approval Checklist

C0 cannot replace the current routine gate until all are true:

- complete inventory and L/B/G/U classification
- versioned manifest/action compiler
- deny-by-default admitted capabilities
- high-order and boundary mutation coverage
- fresh local reference route
- machine-checkable composition premises
- S0-P and S1-D mismatch zero
- S2 migration/rollback/recovery pass
- unrelated component non-invalidation
- exact certificate and independent verifier
- atomic/corruption fallback pass
- false hit zero
- old/new differential mismatch zero in claimed scope
- mutation miss zero in claimed scope
- p95 × safety factor ≤60s
- separate correctness/budget/evidence results
- reproducible Global Exhaustive fallback
- C0 release oracle remains blocking
- separate tests/build/runtime/device gates remain
- storage policy approved
- user approves canonical policy change
- policy rollback verified

## 22. Rejected Current Replacements

Not canonical replacements:

- resolvedIds representatives
- 2,560-class shortcuts
- Gray traversal
- pairwise/covering-array-only
- resolver-only BDD
- unproved components
- initial-plan equivalence
- file-only equivalence
- Merkle-root-only certification
- prospective keys
- unsafe hardlinks
- random/learned sampling
- balanced scheduling as a history proof
- permanent contract-reducing S1

## 23. First Work Package

Only Phase 0:

1. cache correctness fix separation
2. regression preservation
3. worker-history documentation
4. canonical oracle freeze
5. source/target pre/post hashes
6. evidence dispositions
7. target identity correction
8. runtime-envelope classification

Do not implement later phases or advance status automatically.

## 24. Final Principles

```text
Unknown is not success.
Trace is not a capability proof.
One boundary snapshot is not every boundary.
Initial equivalence is not continuation equivalence.
A key match is not a certificate hit.
Budget failure is not correctness failure.
Fresh isolation is the first reference.
State and proof architecture must agree.
Fast admission is earned by bounded patch effects.
Global Exhaustive remains the transition and fallback oracle.
Policy changes require qualification and explicit approval.
```
