#!/usr/bin/env bash
set -euo pipefail

# Install Command Line Tools if not installed on the system
setupCommandLineTools() {
    if type xcode-select >&- && xpath=$(xcode-select --print-path) &&
        test -d "${xpath}" && test -x "${xpath}"; then
        ansi --blue "Command Line Tool already installed"
    else
		ansi --green "Command Line Tool not installed, proceeding..."
        xcode-select --install
    fi
}
