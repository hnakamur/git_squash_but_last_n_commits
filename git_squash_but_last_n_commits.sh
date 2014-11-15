#!/bin/bash
if [ $# -eq 0 ]; then
  echo "Usage: $0 keep_commit_count" 1>&2
  exit 1
fi

# Number of commits to keep (default: 3)
keep_commits=$1

# Calculate the end commit index
old_commits=`git log --pretty=oneline | wc -l`
end=$(($old_commits - $keep_commits))
if [ $end -lt 2 ]; then
  echo "No need to squash" 1>&2
  exit 2
fi

# Save old core.editor value
old_editor=`git config -l --local | sed -n 's/^core\.editor=//p'`

# Do squash
git config --local core.editor "sed -i '' -e '2,${end}s/^pick /squash /'"
git rebase -i --root

# Restore core.editor value
if [ $old_editor ]; then
  git config --local core.editor "$old_editor"
else
  git config --local --unset core.editor
fi

# Do garbage collection
git reflog expire --expire=now --all
git gc --prune=now --aggressive
