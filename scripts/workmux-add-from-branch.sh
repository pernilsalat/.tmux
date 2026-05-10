#!/usr/bin/env bash

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "Not a git repository"
  echo "Press any key to close."
  read -nr 1 -s
  exit 1
fi

git fetch --prune origin >/dev/null 2>&1

selection=$(
  git for-each-ref \
    --format='%(refname:short)' \
    refs/heads \
    refs/remotes/origin \
  | grep -v '^origin/HEAD$' \
  | fzf
)

[ -z "$selection" ] && exit 0

workmux add "$selection" || {
  echo
  echo "workmux add failed. Press any key to close."
  read -nr 1 -s
}
