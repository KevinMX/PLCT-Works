#!/bin/bash

# Define colors
readonly RED='\033[1;31;31m'
readonly GREEN='\033[1;31;32m'
readonly YELLOW='\033[1;31;33m'
readonly NC='\033[0m'

install_deps() {
    if [[ -f "/etc/openEuler-release" ]]; then
        dnf install -y git && export TESTING_OS=openeuler
    elif [[ -f "/etc/debian_version" ]]; then
        apt-get update && apt-get install git && export TESTING_OS=debian
    elif [[ -f "/etc/arch-release" ]]; then
        pacman --noconfirm -Syu git && export TESTING_OS=archlinux
    else
        printf "We only support ${YELLOW}dnf, apt and pacman ${NC}right now.\n"
        printf "So far, nothing is changed on your system. Please check again.\n"
    fi
}

prepare_env(){
    git clone --depth=1 https://github.com/weilinfox/ruyi-mugen
    pushd ruyi-mugen
    bash dep_install.sh
    if [ $TESTING_OS == "openeuler" ]; then
        bash mugen.sh -c --ip 127.0.0.1 --password 'openEuler12#$' --user root --port 22
    elif [ $TESTING_OS == "debian" ]; then
        bash mugen.sh -c --ip 127.0.0.1 --password 'debian' --user root --port 22
    else
        # Define your own password here
        bash mugen.sh -c --ip 127.0.0.1 --password 'password' --user root --port 22
    fi
    
}

run_tests(){
    bash mugen.sh -f ruyi
    echo "Processing logs..."
    for file in $(find ./logs -name "*:*"); do mv "$file" "${file//:/_}"; done
}

install_deps
prepare_env
run_tests