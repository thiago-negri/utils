#!/bin/sh
[ "$(uname)" = "Darwin" ] || exit 1
brew reinstall input-leap
tccutil reset Accessibility input-leap
open "$(brew --prefix)/opt/input-leap/InputLeap.app"
read -p 'ready to open it again? (Y/n) ' ready
[ "$ready" -ne "n" ] && open "$(brew --prefix)/opt/input-leap/InputLeap.app"
