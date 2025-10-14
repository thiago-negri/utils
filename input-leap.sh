#!/usr/bin/env bash
[ "$(uname)" = "Darwin" ] || exit 1
brew reinstall input-leap
tccutil reset Accessibility input-leap
open "$(brew --prefix)/opt/input-leap/InputLeap.app"
read -p 'open it again? (Y/n) ' ready
while [ "$ready" != "n" ]; do
  open "$(brew --prefix)/opt/input-leap/InputLeap.app"
  read -p 'open it again? (Y/n) ' ready
done
