#!/bin/bash


# Figure out current directory to setup global gitignore and commit template
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# CLI tool to pipe stdout to system's clipboard, used to copy current branch name
unameOut="$(uname -s)"
case "${unameOut}" in
    Darwin*)    clipboard=pbcopy;;
    MINGW*)     clipboard=clip;;
    *)          clipboard=xclip -selection clipboard;;
esac


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

# Not really using worktrees, can probably remove those
alias cb        clone --bare
alias wtl       worktree list
alias wta       worktree add
alias wtr       worktree remove

# 'git s' for quick status
alias s         status --short --branch

# 'git ss' is quick status, ignoring untracked files
alias ss        status --short --branch --untracked-files=no

# 'git l' shows a sane log
alias l         log --graph --oneline --decorate

# 'git d' shows unstaged diffs
alias d         diff --minimal

# 'git ds' shows staged diffs
alias ds        diff --staged --minimal

# 'git co <ref>' to switch branches / tags / commits
alias co        checkout

# 'git cof' fuzzy find and checkout a branch
alias cof       "!git checkout \$(git branch --format '%(refname)' | sed 's/refs\/heads\///g' | fzf)"

# 'git resf / git resolvef' to list conflicting files and opening one of them in nvim
alias resf      "!nvim -c '/<<<<<<<\|=======\|>>>>>>>' \$(git diff --name-only --diff-filter=U --relative | fzf)"
alias resolvef  "!nvim -c '/<<<<<<<\|=======\|>>>>>>>' \$(git diff --name-only --diff-filter=U --relative | fzf)"

# 'git res[olve]' to open all conflicting files in nvim
alias res       "!nvim -c '/<<<<<<<\|=======\|>>>>>>>' \$(git diff --name-only --diff-filter=U --relative)"
alias resolve   "!nvim -c '/<<<<<<<\|=======\|>>>>>>>' \$(git diff --name-only --diff-filter=U --relative)"

# 'git aa' stage everything (add all)
alias aa        add -A

# 'git ap' select chunks do stage (add patch)
alias ap        add -p

# 'git rr' unstage everything
alias rr        reset HEAD .

# 'git b' list all local branches
alias b         branch

# 'git bb' shows current branch name
alias bb        branch --show-current

# 'git bc' copies the current branch name to system's clipboard
alias bc        "!git rev-parse --abbrev-ref HEAD | $clipboard"

# 'git rs <ref>' resets HEAD to the base commit between current HEAD and <ref>
#                useful to squash multiple commits in a branch, for example
#                if you're working on a branch with 50 commits and you want to
#                prepare a PR for 'master', you can do:
#                $ git rs master
#                $ git aa
#                $ git cm "new feature squashed into a single commit"
#                $ git push --force # requires --force because you're rewriting history
alias rs        '!f() { git reset --soft $(git merge-base $1 HEAD); }; f'

# 'git rv' list remotes
alias rv        remote --verbose

# 'git cur[rent]' shows the current commit message
alias cur       log HEAD^1..HEAD
alias current   log HEAD^1..HEAD

# 'git c' quick current commit
alias c         log --oneline HEAD^1..HEAD

# 'git pushu' pushes current branch and set it to track remote, use it to
#             push new branches to remote
alias pushu     '!git push -u origin $(git rev-parse --abbrev-ref HEAD)'

# 'git pullf' pulls changes from remote, but only accept it if we can
#             fast-forward the local history, use this on branches you
#             don't commit to locally (e.g. develop, main, master)
alias pullf     pull --ff-only

# 'git pullr' pulls changes from remote, and rebase your local history
#             use this if there's a remote commit you don't have locally
#             but you already committed something else (e.g. fetching from
#             remote GitHub that has an action that formats code)
alias pullr     pull --rebase

# 'git cm <message>' quick commit
alias cm        commit -m

# 'git amend' for amending last commit message
#             this will rewrite history, which requires '--force' if you
#             already pushed to a remote
alias amend     commit --amend

# 'git recommit' for amending last commit using same message (e.g. you forgot
#                to stage a file, or noticed a typo and want to do a quickfix)
#                this will rewrite history, which requires '--force' if you
#                already pushed to a remote
alias recommit  commit --amend -C HEAD

# 'git aliases' to list all aliases
alias aliases   config --get-regexp alias.*

# 'git weekupdate' to list a summary of all commits you did in the past 7 days
alias weekupdate '!git log --oneline --no-merges --author=$(git config --get user.email) --since="7 days ago" --format="format:- %s;"'

# 'git delete-merged-branches' to delete all branches that are merged to current HEAD
#                              it's a long name because it's not something I should be
#                              doing regularly
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
# Checkout as-is, commit LF
git config --global core.autocrlf input

