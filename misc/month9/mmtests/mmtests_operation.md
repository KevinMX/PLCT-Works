#下载预置环境的安装包<br/>
1.mmtests:git clone https://github.com/gormanm/mmtests.git<br/>
2.R-3.6.3:wget https://mirror.lzu.edu.cn/CRAN/src/base/R-3/R-3.6.3.tar.gz<br/>
3.List-BinarySearch:git clone https://github.com/daoswald/List-BinarySearch.git<br/>
4.file-slurp:wget https://cpan.metacpan.org/authors/id/C/CA/CAPOEIRAB/File-Slurp-9999.32.tar.gz<br/>

#预置环境<br/>
1.拷贝第一步的脚本至目标机器的/opt目录<br/>
2.执行prepare_env.sh脚本进行预置环境<br/>

#执行测试用例<br/>
1.拷贝脚本和调度文件至目标机器的/home/mmtests/目录<br/>
2.执行sh runalltest.sh cnf.txt运行mmtests用例<br/>
3.分析失败用例(grep -ir fail log/)并归档日志至蓝云<br/>

