# Bootstrap Prompt

아래 문구에서 `Task:` 아래만 이번 작업으로 바꾸어 LLM에 전달합니다.

```markdown
Use the following public GitHub file as the sole bootstrap entrypoint for this
task:

https://raw.githubusercontent.com/danso0429/patch-verification-governance/main/LLM-ENTRYPOINT.md

Open and read that file completely.

Then follow its authority hierarchy and required read order. You have
permission to inspect all public files linked from that branch and all public
implementation repositories declared in `TARGETS.yaml`.

Do not rely on conversation memory, prior summaries, filenames alone, or
search-result snippets as substitutes for reading the required files.

Before changing anything, report:

1. the exact governance commit;
2. the exact implementation commit;
3. the current canonical verification policy;
4. the current transition phase;
5. the allowed scope for this task;
6. prohibited operations;
7. every required file successfully read;
8. expected changed files;
9. required tests and receipts;
10. fallback and rollback boundaries.

If any required repository, file, branch, or commit cannot be accessed, stop
the dependent work and identify the exact missing resource. Do not infer or
reconstruct its contents.

Perform only the task requested below. Do not advance the transition phase,
change the canonical gate, publish reusable certificates, or migrate production
state unless the current status and an explicit user instruction authorize it.

Task:

[Write the task here.]
```
