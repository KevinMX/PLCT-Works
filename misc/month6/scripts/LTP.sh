#!/bin/bash

LTP_VERSION=20230516
LTP_TIMEOUT_MUL=100

set_yum_repo(){
    rm /etc/yum.repos.d/openEuler.repo
    cat << "EOF" > /etc/yum.repos.d/openEuler.repo
[OS]
name=OS
baseurl=http://121.36.84.172/dailybuild/openEuler-23.09-RISC-V/openeuler-2023-10-17-16-56-53/OS/$basearch/
enabled=1
gpgcheck=1
gpgkey=http://121.36.84.172/dailybuild/openEuler-23.09-RISC-V/openeuler-2023-10-17-16-56-53/OS/$basearch/RPM-GPG-KEY-openEuler
EOF
}

install_dependencies(){
    dnf install -y gcc git make pkgconf autoconf automake bison flex m4 kernel-tools kernel-headers kernel-devel glibc-headers openssl-devel libacl-devel libaio-devel libcap-devel ethtool expect-devel xfsprogs-devel btrfs-progs quota nfs-utils libmnl-devel libtirpc-devel irqbalance
}

init_partitions(){
    echo -e "g\nn\n\n\n\nw" > parts
    fdisk /dev/vdb < parts
    fdisk /dev/vdc < parts
    rm parts
    mkfs.ext4 /dev/vdb1 && mkfs.ext4 /dev/vdc1
}

install_ltp(){
    curl -LO https://github.com/linux-test-project/ltp/releases/download/$LTP_VERSION/ltp-full-$LTP_VERSION.tar.xz
    tar -xvf ltp-full-$LTP_VERSION.tar.xz
    cd ltp-full-$LTP_VERSION
    make autotools
    ./configure --with-bash --with-expect --with-perl --with-python
    make -j$(nproc)
    make install
}

run_ltp(){
    cd /opt/ltp
    mkdir -p /ltp/tmp
    dmesg -Hw > ~/dmesg.log
    ./runltp -p -o tests.output -d /ltp/tmp -b /dev/vdc1 -B ext4 -z /dev/vdb1 -Z ext4
    echo "LTP test finished. Please check log output."
}

set_yum_repo
install_dependencies || echo "Failed to install dependencies." && exit 1
init_partitions || echo "Failed to initialize partitions." && exit 1
install_ltp || echo "LTP installation failed." && exit 1
run_ltp