#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "$DIR/base.sh"
. "$DIR/ansi"

setupBrew() {
	. "$DIR/install_xcode.sh"
	setupCommandLineTools

	if isavailable brew; then
        ansi --blue "Brew already installed"
    else
		ansi --green "Brew is not installed, proceeding..."
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
    fi
}

if [[ "$OSTYPE" == "darwin"* ]]; then
	setupBrew
else
	ansi --yellow "Not a darwin platform. Skipping"
fi
