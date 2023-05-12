#!/bin/bash
numjobs=10
iodepth=10
mkdir test
for rw in read write randread randwrite randrw;do
for bs in 4 16 32 64 128 256 512 1024;do
if [ $rw == "randrw" ];then
fio -filename=test/fio -direct=1 -iodepth ${iodepth} -thread -rw=$rw -rwmixread=70 -ioengine=libaio -bs=${bs}k -size=1G -numjobs=${numjobs} -runtime=30 -group_reporting -name=job1
else
fio -filename=test/fio -direct=1 -iodepth ${iodepth} -thread -rw=$rw -ioengine=libaio -bs=${bs}k -size=1G -numjobs=${numjobs} -runtime=30 -group_reportin -name=job1
fi
sleep 30
done
done