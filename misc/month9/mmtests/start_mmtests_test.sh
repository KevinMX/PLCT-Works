#/usr/bin/bash
prepare_env(){
    dnf install -y git expect tar make pcre-devel bzip2-devel xz-devel libcurl-devel  libcurl texinfo gcc-gfortran java-1.8.0-openjdk-devel gnuplot wget libXt-devel readline-devel glibc-headers R

    cd /opt || exit 1
    until (test -e "mmtests")
    do
        git clone https://github.com/gormanm/mmtests.git
    done

    # #install R
    # mkdir -p /usr/local/R
    # cp /home/mmtests/R-3.6.3.tar.gz /opt/ && cd /opt/
    # ##wget https://mirror.lzu.edu.cn/CRAN/src/base/R-3/R-3.6.3.tar.gz
    # [ -d R-3.6.3 ] && rm -rf R-3.6.3
    # tar -zxf R-3.6.3.tar.gz
    # cd R-3.6.3 || exit 1
    # ./configure --enable-R-shlib=yes --with-tcltk --prefix=/usr/local/R
    # make
    # make install
    # ln -s /usr/local/R/bin/R /usr/bin/R
    # ln -s /usr/local/R/bin/Rscript /usr/bin/Rscript
    
    cp /home/mmtests/List-BinarySearch-v0.25.zip /opt/ && cd /opt/
    ##git clone https://github.com/daoswald/List-BinarySearch.git
    [ -d List-BinarySearch-0.25 ] && rm -rf List-BinarySearch-0.25
    unzip List-BinarySearch-v0.25.zip
    cd List-BinarySearch-0.25 || exit 1
    echo y|perl Makefile.PL
    make
    make test
    make install
    
    cp /home/mmtests/File-Slurp-9999.32.tar.gz /opt/ && cd /opt/
    ##wget https://cpan.metacpan.org/authors/id/C/CA/CAPOEIRAB/File-Slurp-9999.32.tar.gz
    [ -d File-Slurp-9999.32 ] && rm -rf File-Slurp-9999.32
    tar -zxf File-Slurp-9999.32.tar.gz
    cd File-Slurp-9999.32 || exit 1
    perl Makefile.PL -y
    make
    make test
    make install
}

run_mmtests(){
    yum install -y zlib zlib-devel bc httpd net-tools gcc-c++ m4 flex byacc bison keyutils-libs-devel lksctp-tools-devel xfsprogs-devel libacl-devel openssl-devel numactl-devel libaio-devel glibc-devel libcap-devel findutils libtirpc libtirpc-devel kernel-headers glibc-headers hwloc-devel patch numactl tar automake cmake time psmisc git expect fio sysstat  popt-devel libstdc++ libstdc++-static openssl elfutils-libelf-devel slang-devel libbabeltrace-devel zstd-devel gtk2-devel systemtap libtool rpcgen vim

    cp /home/mmtests/cnf* /opt/mmtests
    cd /opt/mmtests || exit 1
    [ -d log ] || mkdir log
    cf=${1-cnf-v0.25.txt}
    configs=$(cat $cf|grep -v "#")
    for cnf in ${configs[@]}
    do
        echo "--------------   start run $cnf   `date +%Y%m%d-%H%M%S`------------------------------"
        rm -rf /opt/mmtests/work/testdisk/ 
        time timeout 7200 bash run-mmtests.sh --no-monitor --config configs/$cnf $cnf 2>&1 | tee log/$cnf.log
        df -h|grep openeuler.*-root
        echo "--------------   end run $cnf     `date +%Y%m%d-%H%M%S`------------------------------"
    done
}

prepare_env
run_mmtests
