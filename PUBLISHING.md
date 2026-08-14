# Publishing This Repository

## Intended repository

```text
https://github.com/danso0429/patch-verification-governance
```

The files in this package are prepared for the repository root.

## GitHub CLI publication

After installing and authenticating GitHub CLI:

```bash
unzip patch-verification-governance.zip
cd patch-verification-governance

git init
git add .
git -c user.name="YOUR NAME" -c user.email="YOUR EMAIL" \
  commit -m "docs: initialize patch verification governance"

gh repo create danso0429/patch-verification-governance \
  --public \
  --source . \
  --remote origin \
  --push
```

## Post-publication checks

Confirm these URLs open:

```text
https://github.com/danso0429/patch-verification-governance
https://raw.githubusercontent.com/danso0429/patch-verification-governance/main/LLM-ENTRYPOINT.md
```

Then change `CURRENT-STATUS.yaml`:

```yaml
publicationStatus: published
```

and commit that status update.

## Safety

Do not add tokens, private repository URLs, server credentials, raw user data,
or unsanitized private receipts.
