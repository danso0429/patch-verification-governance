# Patch Verification Governance

이 저장소는 PocketRisu patch-combination checker의 검증 정책, 전환 상태,
장기 아키텍처와 LLM 작업 진입점을 공개적으로 보관합니다.

> **현재 상태:** Phase 2 완료 승인, Phase 3A read-only entry audit 허가
>
> 이 문서 저장소만으로 checker의 실제 구현이나 정본 정책이 자동으로
> 바뀌지 않습니다. 현재 canonical gate는 여전히 Global Exhaustive이며,
> `CURRENT-STATUS.yaml`과 실제 구현 저장소의 canonical policy가 명시적으로
> 바뀌기 전에는 다른 방식이 이를 대체하지 않습니다. Phase 3A shadow verifier
> 구현은 아직 승인되지 않았습니다.

## LLM 진입점

LLM에는 다음 raw URL 하나와 이번 작업만 전달하면 됩니다.

```text
https://raw.githubusercontent.com/danso0429/patch-verification-governance/main/LLM-ENTRYPOINT.md
```

예시:

```markdown
Read and follow this entrypoint completely:

https://raw.githubusercontent.com/danso0429/patch-verification-governance/main/LLM-ENTRYPOINT.md

Task:
Perform a read-only Phase 3A entry audit only. Do not implement it.
```

## 먼저 읽을 파일

1. [`LLM-ENTRYPOINT.md`](LLM-ENTRYPOINT.md)
2. [`CURRENT-STATUS.yaml`](CURRENT-STATUS.yaml)
3. [`TARGETS.yaml`](TARGETS.yaml)
4. 현재 작업 종류에 맞는 policy, plan 또는 runbook

## 구조

```text
.
├── LLM-ENTRYPOINT.md
├── CURRENT-STATUS.yaml
├── TARGETS.yaml
├── BOOTSTRAP-PROMPT.md
├── docs/
│   ├── current/
│   ├── plans/
│   ├── guides/
│   └── runbooks/
├── decisions/
├── evidence/
├── prompts/
├── schemas/
└── archive/
```

## 매우 중요한 제한

현재 공개 GitHub에서 실제 patcher 구현 저장소와 canonical policy 파일을
확인하지 못했습니다. `danso0429/nai-studio`의 `main` branch는 이 governance
publication의 호스트일 뿐, patcher 구현 정본으로 확인되지 않았습니다.

따라서 source code를 변경하거나 실제 checker를 실행해야 하는 LLM은
`TARGETS.yaml`의 implementation target이 명시적으로 해결될 때까지 추측으로
진행하면 안 됩니다.

## 문서 역할

| 파일 | 역할 |
| --- | --- |
| `LLM-ENTRYPOINT.md` | 모든 LLM 작업의 단일 진입점 |
| `CURRENT-STATUS.yaml` | 현재 Phase, canonical gate, 허용·금지 작업 |
| `TARGETS.yaml` | governance와 implementation 저장소 연결 |
| Final Transition Plan | checker 구조를 바꾸는 최종 설계 및 단계별 승인 조건 |
| Revised Guidance | 현재 checker의 의미와 운용·검수 원칙 |
| Operator Runbook | 실제 작업 순서, preflight, failure와 rollback |
| ADR | 채택한 결정과 기각한 대안의 근거 |
| Evidence Index | 현재 유효한 결과와 한계의 공개 요약 |

## License

별도 라이선스가 추가되기 전까지 이 저장소의 문서는 저작권자의 일반적인
저작권 보호를 받습니다. 공개 열람 가능하다는 사실만으로 재라이선스 권한이
부여되지는 않습니다.
