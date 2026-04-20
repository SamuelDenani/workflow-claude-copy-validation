#!/usr/bin/env bash
# get_changed_blocks.sh
# Outputs the list of .deco/blocks/*.json files modified in the current PR/commit.
# Works both in GitHub Actions (using GITHUB_BASE_REF) and locally (HEAD~1).

set -euo pipefail

BLOCKS_PATH=".deco/blocks"

# Determine diff base
if [ -n "${GITHUB_BASE_REF:-}" ]; then
  # GitHub Actions context: compare against the base branch
  BASE="origin/${GITHUB_BASE_REF}"
  # Ensure we have the base ref fetched
  git fetch origin "${GITHUB_BASE_REF}" --depth=1 2>/dev/null || true
else
  # Local context: compare against previous commit
  BASE="HEAD~1"
fi

git diff --name-only "${BASE}" HEAD -- "${BLOCKS_PATH}/*.json" \
  | grep -E "^${BLOCKS_PATH}/.+\.json$" \
  || true  # Don't fail if no files matched
