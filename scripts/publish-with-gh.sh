#!/usr/bin/env bash
set -euo pipefail

OWNER="${OWNER:-danso0429}"
REPO="${REPO:-patch-verification-governance}"
VISIBILITY="${VISIBILITY:-public}"

command -v gh >/dev/null || { echo "gh is required" >&2; exit 1; }
gh auth status

if [[ ! -d .git ]]; then
  git init
fi

git add .
if ! git diff --cached --quiet; then
  git commit -m "docs: initialize patch verification governance"
fi

gh repo create "${OWNER}/${REPO}" \
  --"${VISIBILITY}" \
  --source . \
  --remote origin \
  --push

printf 'Published: https://github.com/%s/%s\n' "$OWNER" "$REPO"
