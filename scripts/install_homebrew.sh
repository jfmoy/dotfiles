#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. "$DIR/base.sh"
. "$DIR/ansi"

setupBrew() {
	. "$DIR/macos_utils.sh"
	setupCommandLineTools
	isavailable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
	isavailable chezmoi || brew install chezmoi
}

if [[ "$OSTYPE" == "darwin"* ]]; then
	setupBrew
else
	ansi --yellow "Not a darwin platform. Skipping"
fi
