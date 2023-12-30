#!/bin/bash

LTP_VERSION=20230929
LTP_TIMEOUT_MUL=10
#Enter your proxy server here if your network is restricted, i.e. no access to GitHub
PROXY=""

install_dependencies() {
    dnf install -y gcc git make pkgconf autoconf automake bison flex m4 kernel-tools kernel-sg2042-headers kernel-sg2042-devel glibc-headers \
    openssl-devel libacl-devel libaio-devel libcap-devel ethtool expect-devel xfsprogs-devel btrfs-progs quota nfs-utils libmnl-devel libtirpc-devel irqbalance
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
    dmesg -Hw > ~/dmesg.log &
    ./runltp -p -o tests.output -d /ltp/tmp
    echo "LTP test finished. Please check log output."
}

install_dependencies || { echo "Failed to install dependencies." ; exit 1; }
install_ltp || { echo "LTP installation failed." ; exit 1; }
run_ltp
