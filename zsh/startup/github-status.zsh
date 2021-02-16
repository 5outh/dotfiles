#!/bin/zsh

# Print PR status when in a git directory
if git rev-parse --git-dir > /dev/null 2>&1; then
  gh pr status
fi
