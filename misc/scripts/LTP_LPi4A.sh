#!/bin/bash

LTP_VERSION=20230929
#LTP_TIMEOUT_MUL=100
#Enter your proxy server here if your network is restricted, i.e. no access to GitHub
PROXY=""


set_yum_repo() {
    rm /etc/yum.repos.d/openEuler.repo
    cat <<"EOF" >/etc/yum.repos.d/openEuler.repo
[OS]
name=OS
baseurl=https://repo.tarsier-infra.com/openEuler-RISC-V/obs/hwobs_2309/
metalink=https://mirrors.openeuler.org/metalink?repo=$releasever/OS&arch=$basearch
metadata_expire=1h
enabled=1
gpgcheck=1
gpgkey=http://repo.openeuler.org/openEuler-23.09/OS/$basearch/RPM-GPG-KEY-openEuler

[source]
name=source
baseurl=https://repo.tarsier-infra.com/openEuler-RISC-V/obs/hwobs_2309/
metalink=https://mirrors.openeuler.org/metalink?repo=$releasever&arch=source
metadata_expire=1h
enabled=1
gpgcheck=1
gpgkey=http://repo.openeuler.org/openEuler-23.09/source/RPM-GPG-KEY-openEuler
EOF
}

install_dependencies() {
    dnf install -y gcc git make pkgconf autoconf automake bison flex m4 kernel-tools kernel-lpi4a-headers kernel-lpi4a-devel glibc-headers openssl-devel libacl-devel libaio-devel libcap-devel ethtool expect-devel xfsprogs-devel btrfs-progs quota nfs-utils libmnl-devel libtirpc-devel irqbalance
}

init_partitions() {
    echo -e "g\nn\n\n\n\nw" >parts
    if [ ! -b /dev/vdb1 ]; then
        fdisk /dev/vdb <parts
    else
        echo "Partition vdb1 already exists, skipping creation"
    fi
    if [ ! -b /dev/vdc1 ]; then
        fdisk /dev/vdc <parts
    else
        echo "Partition vdc1 already exists, skipping creation"
    fi
    rm parts
    mkfs.ext4 -F /dev/vdb1 && mkfs.ext4 -F /dev/vdc1
}

install_ltp() {
    if [ -f /opt/ltp/runltp ]; then
        echo "LTP is already installed, skipping installation"
    else
        curl -LO ${PROXY}https://github.com/linux-test-project/ltp/releases/download/$LTP_VERSION/ltp-full-$LTP_VERSION.tar.xz
        tar -xvf ltp-full-$LTP_VERSION.tar.xz
        cd ltp-full-$LTP_VERSION
        make autotools
        ./configure --with-bash --with-expect --with-perl --with-python
        make -j$(nproc)
        make install
    fi
}

run_ltp() {
    cd /opt/ltp
    mkdir -p /ltp/tmp
    dmesg -Hw >~/dmesg.log &
    ./runltp -p -o tests.output -d /ltp/tmp -b /dev/vdc1 -B ext4 -z /dev/vdb1 -Z ext4
    echo "LTP test finished. Please check log output."
}

#set_yum_repo || { echo "Failed to overwrite yum repo config."; exit 1; }
install_dependencies || { echo "Failed to install dependencies." ; exit 1; }
#init_partitions || { echo "Failed to initialize partitions." ; exit 1; }
install_ltp || { echo "LTP installation failed." ; exit 1; }
run_ltp
