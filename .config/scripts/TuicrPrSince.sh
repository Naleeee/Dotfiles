#!/bin/bash

# Open tuicr on a PR scoped to what changed since my last review, without the upstream noise
# that "Merge branch 'develop'" commits inside the range would otherwise add to the diff.
set -eu

pr=${1:?usage: TuicrPrSince.sh <pr-number>}

read -r head_sha base < <(gh pr view "$pr" --json headRefOid,baseRefName -q '.headRefOid + " " + .baseRefName')
me=$(gh api user -q .login)
last=$(gh api "repos/{owner}/{repo}/pulls/$pr/reviews" \
  --jq "[.[] | select(.user.login == \"$me\" and .commit_id != null)] | sort_by(.submitted_at) | last | .commit_id // empty")

git fetch -q origin "pull/$pr/head" "$base"

if [ -z "$last" ] || ! git merge-base --is-ancestor "$last" "$head_sha" 2>/dev/null; then
  exec tuicr pr "$pr"
fi

merge_base=$(git merge-base "origin/$base" "$head_sha")
tree=$(git merge-tree --write-tree "$last" "$merge_base" | head -1)
parents=$(git rev-parse "$last^@" | sed 's/^/-p /')
review_base=$(git commit-tree "$tree" $parents -p "$merge_base" -m "review base for PR #$pr")

# Private replace namespace: only git calls made by this tuicr see the swapped commit.
export GIT_REPLACE_REF_BASE=refs/replace-tuicr/
git replace -f "$last" "$review_base"
trap 'git replace -d "$last"' EXIT
tuicr pr "$pr"
