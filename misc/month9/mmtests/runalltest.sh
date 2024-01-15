#/usr/bin/bash
yum install -y zlib zlib-devel bc httpd net-tools gcc-c++ m4 flex byacc bison keyutils-libs-devel lksctp-tools-devel xfsprogs-devel libacl-devel openssl-devel numactl-devel libaio-devel glibc-devel libcap-devel findutils libtirpc libtirpc-devel kernel-headers glibc-headers hwloc-devel patch numactl tar automake cmake time psmisc git expect fio sysstat  popt-devel libstdc++ libstdc++-static openssl elfutils-libelf-devel slang-devel libbabeltrace-devel zstd-devel gtk2-devel systemtap libtool rpcgen vim

\cp ./cnf* /opt/mmtests
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
