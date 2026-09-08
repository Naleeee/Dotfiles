#!/usr/bin/env bash
# Usage: set-project-status.sh <issue-number> <target-status> [only-from-status]
set -euo pipefail

ISSUE_NUMBER="$1"
TARGET_STATUS="$2"
ONLY_FROM="${3:-}"

PROJECT_ID="PVT_kwHOBEry4M4AIjQ_"
STATUS_FIELD_ID="PVTSSF_lAHOBEry4M4AIjQ_zgFUtPk"

case "$TARGET_STATUS" in
  "Todo") OPTION_ID="f75ad846" ;;
  "In Progress") OPTION_ID="47fc9ee4" ;;
  "Done") OPTION_ID="98236657" ;;
  *) echo "Unknown status: $TARGET_STATUS" >&2; exit 1 ;;
esac

ISSUE_ID=$(gh api "repos/$GITHUB_REPOSITORY/issues/$ISSUE_NUMBER" --jq .node_id)

ITEMS=$(gh api graphql -f issue="$ISSUE_ID" -f query='
  query($issue: ID!) {
    node(id: $issue) {
      ... on Issue {
        projectItems(first: 20) {
          nodes {
            id
            project { id }
            fieldValueByName(name: "Status") {
              ... on ProjectV2ItemFieldSingleSelectValue { name }
            }
          }
        }
      }
    }
  }')

ITEM_ID=$(jq -r --arg p "$PROJECT_ID" \
  '.data.node.projectItems.nodes[] | select(.project.id == $p) | .id' <<<"$ITEMS" | head -1)
CURRENT=$(jq -r --arg p "$PROJECT_ID" \
  '.data.node.projectItems.nodes[] | select(.project.id == $p) | .fieldValueByName.name // ""' <<<"$ITEMS" | head -1)

if [ -z "$ITEM_ID" ]; then
  echo "Issue #$ISSUE_NUMBER not in project, adding it"
  ITEM_ID=$(gh api graphql -f project="$PROJECT_ID" -f content="$ISSUE_ID" -f query='
    mutation($project: ID!, $content: ID!) {
      addProjectV2ItemById(input: {projectId: $project, contentId: $content}) {
        item { id }
      }
    }' --jq '.data.addProjectV2ItemById.item.id')
  CURRENT=""
fi

if [ -n "$ONLY_FROM" ] && [ -n "$CURRENT" ] && [ "$CURRENT" != "$ONLY_FROM" ]; then
  echo "Issue #$ISSUE_NUMBER is '$CURRENT', not '$ONLY_FROM' — leaving as is"
  exit 0
fi

gh api graphql -f project="$PROJECT_ID" -f item="$ITEM_ID" -f field="$STATUS_FIELD_ID" -f option="$OPTION_ID" -f query='
  mutation($project: ID!, $item: ID!, $field: ID!, $option: String!) {
    updateProjectV2ItemFieldValue(input: {
      projectId: $project, itemId: $item, fieldId: $field,
      value: {singleSelectOptionId: $option}
    }) {
      projectV2Item { id }
    }
  }' >/dev/null

echo "Issue #$ISSUE_NUMBER → $TARGET_STATUS"
