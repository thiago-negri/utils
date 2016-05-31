#!/bin/sh

alias () {
  name=$1
  shift
  args=$*

  echo "git $name\n\tgit $args"

  git config --global --unset-all alias.$name
  git config --global alias.$name "$args"
}

alias s         status --short --branch
alias l         log --graph --oneline --decorate

alias ss        status --short --untracked-files=no
alias ds        diff --staged
alias co        checkout
alias aa        add -A

alias current   log HEAD^1..HEAD
alias cur       log HEAD^1..HEAD

alias ammend    commit --amend
alias recommit  commit --amend -C HEAD
alias aliases   config --get-regexp alias.*

