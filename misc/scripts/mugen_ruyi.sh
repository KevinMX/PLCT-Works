#!/bin/bash

# Define colors
readonly RED='\033[1;31;31m'
readonly GREEN='\033[1;31;32m'
readonly YELLOW='\033[1;31;33m'
readonly NC='\033[0m'

if [ ! $1 ]; then
    printf "${RED}Please enter your root password!${NC}\n"
    echo "e.g. bash mugen_ruyi.sh root_password"
    exit 1
fi

install_deps() {
    if [[ -f "/etc/openEuler-release" ]]; then
        dnf install -y git
    elif [[ -f "/etc/debian_version" ]]; then
        apt-get update && apt-get install git
    elif [[ -f "/etc/arch-release" ]]; then
        pacman --noconfirm -Syu git
    else
        printf "We only support ${YELLOW}dnf, apt and pacman ${NC}right now.\n"
        printf "So far, nothing is changed on your system. Please check again.\n"
    fi
}

prepare_env() {
    if [[ -d ~/ruyi-mugen ]]; then
        mv ruyi-mugen ruyi-mugen-$(date +%F_%H-%M-%S)-bak
    fi
    git clone --depth=1 https://github.com/weilinfox/ruyi-mugen
    cd ruyi-mugen
    bash dep_install.sh
    bash mugen.sh -c --ip 127.0.0.1 --user root --password '$1' --port 22
}

run_tests() {
    bash mugen.sh -f ruyi
    echo "Processing logs..."
    for file in $(find ./logs -name "*:*"); do mv "$file" "${file//:/_}"; done
}

install_deps
prepare_env
run_tests
