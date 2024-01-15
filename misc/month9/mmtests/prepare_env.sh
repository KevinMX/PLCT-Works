#/usr/bin/bash
dnf install -y git expect tar make pcre-devel bzip2-devel xz-devel libcurl-devel  libcurl texinfo gcc-gfortran java-1.8.0-openjdk-devel gnuplot wget libXt-devel readline-devel glibc-headers R

cd /opt || exit 1
until (test -e "mmtests")
do
    git clone https://github.com/gormanm/mmtests.git
done
echo -e "\033[32mmmtests prepare finished\033[0m"

# #install R
# mkdir -p /usr/local/R
# ##\cp /home/mmtests/R-3.6.3.tar.gz /opt/ && cd /opt/
# wget https://mirror.lzu.edu.cn/CRAN/src/base/R-3/R-3.6.3.tar.gz
# [ -d R-3.6.3 ] && rm -rf R-3.6.3
# tar -zxf R-3.6.3.tar.gz
# cd R-3.6.3 || exit 1
# ./configure --enable-R-shlib=yes --with-tcltk --prefix=/usr/local/R
# make
# make install
# ln -s /usr/local/R/bin/R /usr/bin/R
# ln -s /usr/local/R/bin/Rscript /usr/bin/Rscript
# echo -e "\033[32mR-3.6.3 make finished\033[0m"

##\cp /home/mmtests/List-BinarySearch-v0.25.zip /opt/ && cd /opt/
git clone https://github.com/daoswald/List-BinarySearch.git
[ -d List-BinarySearch-0.25 ] && rm -rf List-BinarySearch-0.25
unzip List-BinarySearch-v0.25.zip
cd List-BinarySearch-0.25 || exit 1
echo y|perl Makefile.PL
make
make test
make install
echo -e "\033[32mList-Binary make finished\033[0m"

##\cp /home/mmtests/File-Slurp-9999.32.tar.gz /opt/ && cd /opt/
wget https://cpan.metacpan.org/authors/id/C/CA/CAPOEIRAB/File-Slurp-9999.32.tar.gz
[ -d File-Slurp-9999.32 ] && rm -rf File-Slurp-9999.32
tar -zxf File-Slurp-9999.32.tar.gz
cd File-Slurp-9999.32 || exit 1
perl Makefile.PL -y
make
make test
make install
echo -e "\033[32mFile-Slurp make finished\033[0m"
