#!/bin/sh

#
# Setup aliases
#

alias () {
  name=$1
  shift
  args=$*

  echo "git $name\n\tgit $args"

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

alias current   log HEAD^1..HEAD
alias cur       log HEAD^1..HEAD

alias ammend    commit --amend
alias recommit  commit --amend -C HEAD
alias aliases   config --get-regexp alias.*

#
# Setup commit template
#

echo "Setting up template"

git config --global commit.template git_commit_template.txt


