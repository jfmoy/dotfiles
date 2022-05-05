#!/usr/bin/env bash
set -euo pipefail

DIR=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)")
. "$DIR/scripts/base.sh"
. "$DIR/scripts/ansi"

export HOMEBREW_CORE_BUNDLE_FILE="$DIR/Brewfile.core"
export HOMEBREW_BUNDLE_FILE="$DIR/Brewfile"

if [[ "$OSTYPE" == "darwin"* ]]; then
    . "$DIR/scripts/install_homebrew.sh"
	setupBrew

	ansi --green "Using $HOMEBREW_BUNDLE_FILE bundle file"

	brew bundle
else
	ansi --yellow "Not a darwin platform. Skipping"
fi