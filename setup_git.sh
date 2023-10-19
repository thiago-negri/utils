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

alias s         status --short --branch
alias l         log --graph --oneline --decorate

alias ss        status --short --branch --untracked-files=no
alias ds        diff --staged
alias co        checkout
alias aa        add -A
alias rr        reset HEAD .
alias bb        branch --show-current

alias current   log HEAD^1..HEAD
alias cur       log HEAD^1..HEAD

alias pushu     '!git push -u origin $(git branch --show-current)'
alias pullf     pull --ff-only

alias amend     commit --amend
alias recommit  commit --amend -C HEAD
alias aliases   config --get-regexp alias.*

alias weekupdate '!git log --oneline --no-merges --author=$(git config --get user.email) --since="7 days ago" --format="format:- %s;"'

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

