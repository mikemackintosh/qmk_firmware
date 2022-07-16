#!/usr/bin/env bash

_qmk_install_prepare() {
    echo "Checking Homebrew installation"

    if ! brew --version >/dev/null 2>&1; then
        echo "Error! Homebrew is broken or not installed."
        echo "Please run \`brew doctor\` or follow the installation instructions at https://brew.sh/, then re-run this script."
        return 1
    fi

    # brew update && brew upgrade --formulae --ignore-pinned
    arch -arm64 brew update && arch -arm64 brew upgrade --ignore-pinned
}

_qmk_install() {
    echo "Installing dependencies"

    # All macOS dependencies are managed in the Homebrew package:
    # https://github.com/qmk/homebrew-qmk
    arch -arm64 brew install qmk/qmk/qmk

    arch -arm64 brew link --force avr-gcc@8
    arch -arm64 brew link --force arm-gcc-bin@8

    python3 -m pip install -r $QMK_FIRMWARE_DIR/requirements.txt
}
