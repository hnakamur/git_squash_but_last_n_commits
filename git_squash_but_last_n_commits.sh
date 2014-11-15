#!/bin/bash
if [ $# -eq 0 ]; then
  echo "Usage: $0 keep_commit_count" 1>&2
  exit 1
fi

# Number of commits to keep (default: 3)
keep_commits=$1

# Calculate the end commit index
old_commits=`git log --pretty=oneline | wc -l`
end=$(($old_commits - 1 - $keep_commits))
if [ $end -lt 2 ]; then
  echo "No need to squash" 1>&2
  exit 2
fi

# Do squash
if [ `uname -s` = Darwin -a `which sed` = /usr/bin/sed ]; then
  editor="sed -i '' -e '2,${end}s/^pick /squash /'"
else
  editor="sed -i -e '2,${end}s/^pick /squash /'"
fi
initial_commit=`git log --pretty=format:%H | tail -1`
git -c core.editor="$editor" rebase -i $initial_commit

# Do garbage collection
git reflog expire --expire=now --all
git gc --prune=now --aggressive
