#!/bin/sh
[ "$(uname)" = "Darwin" ] || exit 1
brew reinstall input-leap
tccutil reset Accessibility input-leap
open "$(brew --prefix)/opt/input-leap/InputLeap.app"
