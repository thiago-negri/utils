#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#
# Setup aliases
#

alias () {
  name=$1
  shift
  args=$*

  echo "git $name --> git $args"

  git config --global --unset-all alias.$name
  git config --global alias.$name "$args"
}

echo "Setting up aliases"

alias cb        clone --bare
alias wtl       worktree list
alias wta       worktree add
alias wtr       worktree remove

alias s         status --short --branch
alias l         log --graph --oneline --decorate

alias ss        status --short --branch --untracked-files=no
alias ds        diff --staged
alias d         '!git diff --name-only --relative --diff-filter=d | xargs bat --diff'
alias co        checkout
alias cof       "!git checkout \$(git branch --format '%(refname)' | sed 's/refs\/heads\///g' | fzf)"
alias aa        add -A
alias rr        reset HEAD .
alias bb        branch --show-current
alias rs        '!f() { git reset --soft $(git merge-base $1 HEAD); }; f'

alias current   log HEAD^1..HEAD
alias cur       log HEAD^1..HEAD
alias c         log --oneline HEAD^1..HEAD

alias pushu     '!git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias pullf     pull --ff-only
alias pullr     pull --rebase

alias amend     commit --amend
alias recommit  commit --amend -C HEAD
alias aliases   config --get-regexp alias.*

alias weekupdate '!git log --oneline --no-merges --author=$(git config --get user.email) --since="7 days ago" --format="format:- %s;"'

alias delete-merged-branches '!git for-each-ref --format "%(refname:short)" --merged HEAD refs/heads/ | grep -v "$(git rev-parse --abbrev-ref HEAD)" | xargs git branch -D'

#
# Setup commit template
#

echo "Setting up template"

git config --global commit.template "$DIR/git_commit_template.txt"

#
# Setup global ignores
#

echo "Setting up global ignores"

git config --global core.excludesfile "$DIR/gitignore_global"

#
# Other configs
#
# Automatically remove stale branches
git config --global fetch.prune true

