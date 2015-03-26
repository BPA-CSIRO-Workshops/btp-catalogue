#!/bin/bash

install_dir='/tools'
owner='root'
tools_location='https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools'


#############
## Prepare ##
#############
apt-get update
# Prefer IPv4 over IPv6
echo "precedence ::ffff:0:0/96 100" >> /etc/gai.conf
packages=()
####################


###################
## Miscellaneous ##
###################
packages=(${packages[*]} wget curl vim screen zip unzip)
####################


###############
## Compilers ##
###############
packages=(${packages[*]} gcc g++ gfortran cmake cmake-curses-gui)
####################


##########################
## Development Packages ##
##########################
packages=(${packages[*]} libgtextutils-dev libgtextutils0 libblas-dev liblapack-dev
texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended
libgd-barcode-perl libgd-graph-perl libgd-graph3d-perl libxml-perl ant
libstatistics-descriptive-perl libdbi-perl python-setuptools libdbd-pg-perl
xorg-dev texinfo build-essential libpng12-0-dev libmysqlclient-dev hmmer
libboost1.48-all-dev libssl-dev zlib1g-dev ncurses-dev xorg-dev csh
libreadline6-dev texlive-latex-base texlive-fonts-extra libfontconfig1-dev 
libfreetype6-dev libx11-dev libxcursor-dev libxext-dev libxft-dev 
libxi-dev libxrandr-dev libxrender-dev libqt4-dev python-software-properties
libxml2-dev libeigen3-dev libeigen3-doc libcurl4-openssl-dev autoconf)
####################


#####################
## Package Install ##
#####################
apt-get install -y ${packages[@]}
####################


################
## Pre Flight ##
################
cp -r /usr/include/eigen3/Eigen /usr/include/
####################


##########
## Java ##
##########
apt-add-repository -y ppa:webupd8team/java
apt-get update
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
apt-get install -y oracle-java8-installer
####################


############
## Puppet ##
############
cd /tmp/
ubuntu_version=`lsb_release -s -c`
wget -4 --no-check-certificate https://apt.puppetlabs.com/puppetlabs-release-$ubuntu_version.deb
dpkg -i puppetlabs-release-$ubuntu_version.deb
apt-get update
apt-get install -y puppet
rm puppetlabs-release-$ubuntu_version.deb
####################


###############
## gnx-tools ##
###############
cd /tmp/
# Download DEB package
wget -4 --no-check-certificate $tools_location/gnx-tools_0.1+20120305-1_all.deb
dpkg -i gnx-tools_0.1+20120305-1_all.deb
# Cleanup
rm gnx-tools_0.1+20120305-1_all.deb
####################


############
## FastQC ##
############
tool_name='FastQC'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the jar files
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/fastqc_v0.11.2.zip
unzip fastqc_v0.11.2.zip
mv FastQC 0.11.2
chmod a+x $install_dir/$tool_name/0.11.2/fastqc
chmod a+rx -R $install_dir/$tool_name/0.11.2
ln -s $install_dir/$tool_name/0.11.2 $install_dir/$tool_name/fastqc-default
# Cleanup
rm fastqc_v0.11.2.zip
####################


###################
## FASTX-Toolkit ##
###################
tool_name='FASTX-Toolkit'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/fastx_toolkit-0.0.14.tar.bz2
tar -xjf fastx_toolkit-0.0.14.tar.bz2
# Compile
cd fastx_toolkit-0.0.14
./configure --prefix=$install_dir/$tool_name/0.0.14
make; make install
chmod a+rx -R $install_dir/$tool_name/0.0.14
ln -s $install_dir/$tool_name/0.0.14 $install_dir/$tool_name/fastx-toolkit-default
# Cleanup
cd ../
rm -r fastx_toolkit-0.0.14
rm fastx_toolkit-0.0.14.tar.bz2
####################


############
## Picard ##
############
tool_name='Picard'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the jar files
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/picard-tools-1.119.zip
unzip picard-tools-1.119.zip
mv picard-tools-1.119 1.119
chmod a+rx -R $install_dir/$tool_name/1.119
ln -s $install_dir/$tool_name/1.119 $install_dir/$tool_name/picard-default
# Cleanup
rm picard-tools-1.119.zip
####################


############
## Bowtie ##
############
tool_name='Bowtie'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/bowtie-1.1.1-src.zip
unzip bowtie-1.1.1-src.zip
# Compile
mv bowtie-1.1.1 1.1.1
cd 1.1.1/
make
chmod a+rx -R $install_dir/$tool_name/1.1.1
ln -s $install_dir/$tool_name/1.1.1 $install_dir/$tool_name/bowtie-default
# Cleanup
cd ../
rm bowtie-1.1.1-src.zip
####################


##############
## Bowtie 2 ##
##############
tool_name='Bowtie'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/bowtie2-2.2.4-source.zip
unzip bowtie2-2.2.4-source.zip
# Compile
mv bowtie2-2.2.4 2.2.4
cd 2.2.4/
make
chmod a+rx -R $install_dir/$tool_name/2.2.4
ln -s $install_dir/$tool_name/2.2.4 $install_dir/$tool_name/bowtie2-default
# Cleanup
cd ../
rm bowtie2-2.2.4-source.zip
####################


##############
## SAMtools ##
##############
tool_name='SAMtools'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/samtools-0.1.19.tar.bz2
tar -xjf samtools-0.1.19.tar.bz2
# Compile
mv samtools-0.1.19 0.1.19
cd 0.1.19/
make
mkdir -p $install_dir/$tool_name/0.1.19/lib
cp $install_dir/$tool_name/0.1.19/libbam.a $install_dir/$tool_name/0.1.19/lib/
mkdir -p $install_dir/$tool_name/0.1.19/include/bam
cp $install_dir/$tool_name/0.1.19/*.h $install_dir/$tool_name/0.1.19/include/bam/
chmod a+rx -R $install_dir/$tool_name/0.1.19
ln -s $install_dir/$tool_name/0.1.19 $install_dir/$tool_name/samtools-default
# Cleanup
cd ../
rm samtools-0.1.19.tar.bz2
####################


##############
## bedtools ##
##############
tool_name='bedtools'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/bedtools-2.22.1.tar.gz
tar -xzf bedtools-2.22.1.tar.gz
# Compile
mv bedtools2 2.22.1
cd 2.22.1
make
chmod a+rx -R $install_dir/$tool_name/2.22.1
ln -s $install_dir/$tool_name/2.22.1 $install_dir/$tool_name/bedtools-default
# Cleanup
cd ../
rm bedtools-2.22.1.tar.gz
####################


###############
## UCSCTools ##
###############
tool_name='UCSCTools'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/userApps.v310.src.tgz
tar -xzf userApps.v310.src.tgz
# Compile
cd userApps/
make
chmod a+rx -R $install_dir/$tool_name/userApps
ln -s $install_dir/$tool_name/userApps $install_dir/$tool_name/ucsctools-default
# Cleanup
cd ../
rm userApps.v310.src.tgz
####################


############
## Velvet ##
############
tool_name='Velvet'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/velvet_1.2.10.tgz
tar -xzf velvet_1.2.10.tgz
# Compile
mv velvet_1.2.10 1.2.10
cd 1.2.10
make 'MAXKMERLENGTH=59' 'LONGSEQUENCES=1' 'OPENMP=1'
make 'MAXKMERLENGTH=59' 'LONGSEQUENCES=1' 'OPENMP=1' color
make doc
chmod a+rx -R $install_dir/$tool_name/1.2.10
ln -s $install_dir/$tool_name/1.2.10 $install_dir/$tool_name/velvet-default
# Cleanup
cd ../
rm velvet_1.2.10.tgz
####################


##########
## MACS ##
##########
tool_name='MACS'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/v1.4.2.tar.gz
tar -xzf v1.4.2.tar.gz
# Compile
cd MACS-1.4.2/
python setup.py install --prefix $install_dir/$tool_name/1.4.2
chmod a+rx -R $install_dir/$tool_name/1.4.2
ln -s $install_dir/$tool_name/1.4.2 $install_dir/$tool_name/macs-default
# Cleanup
cd ../
rm -r MACS-1.4.2
rm v1.4.2.tar.gz
####################


##################
## PeakAnalyzer ##
##################
tool_name='PeakAnalyzer'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the jar files
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/PeakAnalyzer_1.4.tar.gz
tar -xzf PeakAnalyzer_1.4.tar.gz
mv PeakAnalyzer_1.4 1.4
chmod a+rx -R $install_dir/$tool_name/1.4
ln -s $install_dir/$tool_name/1.4 $install_dir/$tool_name/peakanalyzer-default
# Cleanup
rm PeakAnalyzer_1.4.tar.gz
####################


############
## TopHat ##
############
tool_name='TopHat'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the jar files
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/tophat-1.4.1.tar.gz
tar -xzf tophat-1.4.1.tar.gz
# Compile
cd tophat-1.4.1
./configure --prefix=$install_dir/$tool_name/1.4.1 --with-bam=$install_dir/SAMtools/samtools-default 
make all
make install
chmod a+rx -R $install_dir/$tool_name/1.4.1
ln -s $install_dir/$tool_name/1.4.1 $install_dir/$tool_name/tophat-default
# Cleanup
cd ../
rm -r tophat-1.4.1
rm tophat-1.4.1.tar.gz
####################


##############
## TopHat 2 ##
##############
tool_name='TopHat'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the jar files
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/tophat-2.0.13.tar.gz
tar -xzf tophat-2.0.13.tar.gz
# Compile
cd tophat-2.0.13
./configure --prefix=$install_dir/$tool_name/2.0.13 --with-bam=$install_dir/SAMtools/samtools-default 
make all
make install
chmod a+rx -R $install_dir/$tool_name/2.0.13
ln -s $install_dir/$tool_name/2.0.13 $install_dir/$tool_name/tophat2-default
# Cleanup
cd ../
rm -r tophat-2.0.13
rm tophat-2.0.13.tar.gz
####################


###############
## Cufflinks ##
###############
tool_name='Cufflinks'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/cufflinks-2.2.1.tar.gz
tar -xzf cufflinks-2.2.1.tar.gz
# Compile
cd cufflinks-2.2.1/
./configure --prefix=/tools/Cufflinks/2.2.1 --with-bam=/tools/SAMtools/samtools-default --with-boost=/usr/
make all
make install
chmod a+rx -R $install_dir/$tool_name/2.2.1
ln -s $install_dir/$tool_name/2.2.1 $install_dir/$tool_name/cufflinks-default
# Cleanup
cd ../
rm -r cufflinks-2.2.1/
rm cufflinks-2.2.1.tar.gz
####################


#########
## IGV ##
#########
tool_name='IGV'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the jar files
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/IGV_2.3.40.zip
unzip IGV_2.3.40.zip
mv IGV_2.3.40 2.3.40
chmod a+rx -R $install_dir/$tool_name/2.3.40
ln -s $install_dir/$tool_name/2.3.40 $install_dir/$tool_name/igv-default
# Cleanup
rm IGV_2.3.40.zip
####################


##############
## IGVTools ##
##############
tool_name='IGVTools'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the jar files
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/igvtools_2.3.40.zip
unzip igvtools_2.3.40.zip
chmod a+rx -R $install_dir/$tool_name/2.3.40
ln -s $install_dir/$tool_name/2.3.40 $install_dir/$tool_name/igvtools-default
mv IGVTools 2.3.40
# Cleanup
rm igvtools_2.3.40.zip
####################


#######
## R ##
#######
ubuntu_version=`lsb_release -s -c`
cat > /etc/apt/sources.list.d/r.list << EOF
deb http://cran.csiro.au/bin/linux/ubuntu $ubuntu_version/
EOF
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
apt-get update
apt-get install -y r-base
# Additional R Libraries
cd /tmp/
cat > /tmp/additional.R << EOF
source("http://bioconductor.org/biocLite.R")
biocLite("DESeq2")
biocLite("edgeR")
biocLite("cummeRbund")
install.packages(pkgs="gplots",repos="http://cran.csiro.au/")
EOF
/usr/bin/R CMD BATCH /tmp/additional.R
####################


############
## MUMmer ##
############
tool_name='MUMmer'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/MUMmer3.23.tar.gz
tar -xzf MUMmer3.23.tar.gz
mv MUMmer3.23 3.23
cd 3.23
make check
make install
chmod a+rx -R $install_dir/$tool_name/3.23
ln -s $install_dir/$tool_name/3.23 $install_dir/$tool_name/mummer-default
# Cleanup
cd ../
rm MUMmer3.23.tar.gz
####################


##########
## BLAT ##
##########
tool_name='BLAT'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/blatSrc35.zip
unzip blatSrc35.zip
mkdir -p $install_dir/$tool_name/35/bin
cd blatSrc/
sed -i 's/\s*BINDIR\s*=\s*${HOME}\/bin\/${MACHTYPE}/BINDIR=\/tools\/BLAT\/35\/bin/g' inc/common.mk
export MACHTYPE=x86_64
make
chmod a+rx -R $install_dir/$tool_name/35
ln -s $install_dir/$tool_name/35 $install_dir/$tool_name/blat-default
# Cleanup
cd ../
rm blatSrc35.zip
####################


##########
## AMOS ##
##########
tool_name='AMOS'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/amos-3.1.0.tar.gz
tar -xzf amos-3.1.0.tar.gz
cd amos-3.1.0/
export PATH=$install_dir/MUMmer/mummer-default:$PATH
export PATH=$install_dir/BLAT/blat-default:$PATH
./configure --prefix=$install_dir/$tool_name/3.1.0 --enable-minimus=no
make
make install
chmod a+rx -R $install_dir/$tool_name/3.1.0
ln -s $install_dir/$tool_name/3.1.0 $install_dir/$tool_name/amos-default
# Cleanup
cd ../
rm -r amos-3.1.0/
rm amos-3.1.0.tar.gz
####################


###########
## QIIME ##
###########
easy_install -U pip
easy_install -U distribute
pip install numpy==1.7.1
pip install qiime
####################


#################
## Setup Paths ##
#################
chown -R $owner.$owner $install_dir
echo "" >> /etc/bash.bashrc
echo "# BPA CSIRO NGS Tools" >> /etc/bash.bashrc
echo "alias gnx=/usr/bin/gnx-tools" >> /etc/bash.bashrc
echo "export LD_LIBRARY_PATH=/tools/Qt/qt-default/lib:\$LD_LIBRARY_PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/FastQC/fastqc-default:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/FASTX-Toolkit/fastx-toolkit-default/bin:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/Picard/picard-default:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/Bowtie/bowtie-default:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/Bowtie/bowtie2-default:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/SAMtools/samtools-default:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/SAMtools/samtools-default/bcftools:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/SAMtools/samtools-default/misc:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/bedtools/bedtools-default/bin:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/UCSCTools/ucsctools-default/bin:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/IGV/igv-default:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/IGVTools/igvtools-default:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/MACS/macs-default/bin:\$PATH" >> /etc/bash.bashrc
echo "alias macs=/tools/MACS/macs-default/bin/macs14" >> /etc/bash.bashrc
echo "export PYTHONPATH=/tools/MACS/macs-default/lib/python2.7/site-packages:\$PYTHONPATH" >> /etc/bash.bashrc
echo "export PATH=/tools/TopHat/tophat-default/bin:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/TopHat/tophat2-default/bin:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/Cufflinks/cufflinks-default/bin:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/Velvet/velvet-default:\$PATH" >> /etc/bash.bashrc
echo "alias velveth_long=/tools/Velvet/velvet-default/velveth" >> /etc/bash.bashrc
echo "alias velvetg_long=/tools/Velvet/velvet-default/velvetg" >> /etc/bash.bashrc
echo "export PATH=/tools/MUMmer/mummer-default:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/BLAT/blat-default/bin:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/AMOS/amos-default/bin:\$PATH" >> /etc/bash.bashrc
