#!/bin/bash


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
    dnf install -y gcc gcc-* dejagnu git
}

get_testsuite(){
    git clone --depth=1 https://gitee.com/openeuler/gcc
}

run_testsuite(){
    cd gcc/gcc/testsuite
    runtest --tool gcc &
    runtest --tool g++ &
    runtest --tool gfortran &
}

set_yum_repo
install_dependencies || echo "Failed to install dependencies." && exit 1
get_testsuite || echo "Failed to clone openEuler's GCC repo." && exit 1
run_testsuite || echo "Failed to run testsuite."  && exit 1