#!/bin/bash

# Define colors
readonly RED='\033[1;31;31m'
readonly GREEN='\033[1;31;32m'
readonly YELLOW='\033[1;31;33m'
readonly NC='\033[0m'

if [ ! "$1" ]; then
    printf "${RED}Please enter your root password!${NC}\n"
    echo "e.g. bash mugen_ruyi.sh root_password"
    exit 1
else
    password=$1
fi

install_deps() {
    if [[ -f "/etc/openEuler-release" ]]; then
        dnf install -y git
    elif [[ -f "/etc/debian_version" ]]; then
        apt-get update && apt-get install -y git
    elif [[ -f "/etc/arch-release" ]]; then
        pacman --noconfirm -Syu git
    else
        printf "We only support ${YELLOW}dnf, apt and pacman ${NC}right now.\n"
        printf "So far, nothing is changed on your system. Please check again.\n"
        exit 1
    fi
}

retry_git_clone() {
    local max_attempts=3
    local attempt=1

    until git clone --depth=1 https://github.com/weilinfox/ruyi-mugen; do
        printf "${YELLOW}Failed to clone the repository. Retrying...${NC}\n"
        sleep 3
        attempt=$((attempt + 1))
        if [ $attempt -gt $max_attempts ]; then
            printf "${RED}Exceeded maximum retry attempts. Exiting.${NC}\n"
            exit 1
        fi
    done
}

prepare_env() {
    if [[ -d ~/ruyi-mugen ]]; then
        mv ruyi-mugen ruyi-mugen-$(date +%F_%H-%M-%S)-bak
    fi
    retry_git_clone
    cd ruyi-mugen || exit 1
    bash dep_install.sh || exit 1
    bash mugen.sh -c --ip 127.0.0.1 --user root --password "$password" --port 22
}

run_tests() {
    bash mugen.sh -f ruyi
    echo "Processing logs..."
    find ./logs -name "*:*" -execdir mv {} "${PWD}/{}" \;
}

install_deps
prepare_env
run_tests
