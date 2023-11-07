#!/bin/bash

BRANCH="openEuler-23.09"
PROXY=""

set_yum_repo() {
    rm /etc/yum.repos.d/openEuler.repo
    cat <<"EOF" >/etc/yum.repos.d/openEuler.repo
[OS]
name=OS
baseurl=https://mirror.iscas.ac.cn/openeuler-sig-riscv/openEuler-RISC-V/testing/20231106/v0.1/repo/
#metalink=https://mirrors.openeuler.org/metalink?repo=$releasever/OS&arch=$basearch
#metadata_expire=1h
enabled=1
gpgcheck=1
gpgkey=http://repo.openeuler.org/openEuler-23.09/OS/$basearch/RPM-GPG-KEY-openEuler

[source]
name=source
baseurl=http://repo.openeuler.org/openEuler-23.09/source/
metalink=https://mirrors.openeuler.org/metalink?repo=$releasever&arch=source
metadata_expire=1h
enabled=1
gpgcheck=1
gpgkey=http://repo.openeuler.org/openEuler-23.09/source/RPM-GPG-KEY-openEuler
EOF
}

install_dependencies() {
    sudo dnf install -y rpmdevtools nodejs
}

get_source() {
    rpmdev-setuptree
    dnf download --source nodejs
    mv nodejs*.rpm ~/rpmbuild/SOURCES
    cd ~/rpmbuild/SOURCES
    rpm2cpio nodejs*.rpm | cpio -iv
    sudo dnf builddep -y nodejs.spec
    rpmbuild -bp nodejs.spec
}

run_test() {
    cd ~/rpmbuild/BUILD/node*
    mkdir -p out/Release && pushd out/Release
    if [ -f ~/rpmbuild/BUILD/node-18.16.0/out/Release/node ]; then
    ln -s /usr/bin/node .
    fi
    popd
    ./tools/test.py --logfile ~/node_$(date +%Y%m%d-%H%M%S).log -p tap -j$(($(nproc)-2)) | tee ~/node_failed_$(date +%Y%m%d-%H%M%S).log
    echo "Test finished. Please check log output."
}

set_yum_repo || { echo "Failed to overwrite yum repo config."; exit 1; }
install_dependencies || { echo "Failed to install dependencies." ; exit 1; }
get_source || { echo "Failed to initialize node source." ; exit 1; }
run_test || { echo "Node test failed." ; exit 1; }