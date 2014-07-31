#!/bin/bash

install_dir='/tools'
owner='root'

#############
## Prepare ##
#############
apt-get update
####################


###################
## Miscellaneous ##
###################
apt-get install -y wget 
apt-get install -y curl 
apt-get install -y vim 
apt-get install -y screen
apt-get install -y zip
apt-get install -y unzip
####################


###############
## Compilers ##
###############
apt-get install -y gcc
apt-get install -y g++ 
apt-get install -y gfortran
apt-get install -y cmake
apt-get install -y cmake-curses-gui
####################


##########################
## Development Packages ##
##########################
apt-get install -y libgtextutils-dev
apt-get install -y libgtextutils0
apt-get install -y libgd-barcode-perl
apt-get install -y libgd-graph-perl
apt-get install -y libgd-graph3d-perl
apt-get install -y libstatistics-descriptive-perl
apt-get install -y libdbi-perl
apt-get install -y xorg-dev
apt-get install -y texinfo
apt-get install -y build-essential
apt-get install -y libpng12-0-dev
apt-get install -y libmysqlclient-dev
apt-get install -y libboost-dev
apt-get install -y libboost-doc
apt-get install -y libboost-thread-dev
apt-get install -y libboost-random-dev
apt-get install -y libssl-dev
apt-get install -y zlib1g-dev
apt-get install -y ncurses-dev
apt-get install -y xorg-dev
apt-get install -y libreadline6-dev
apt-get install -y texlive-latex-base
apt-get install -y texlive-fonts-extra
apt-get install -y libfontconfig1-dev
apt-get install -y libfreetype6-dev
apt-get install -y libx11-dev
apt-get install -y libxcursor-dev
apt-get install -y libxext-dev
apt-get install -y libxft-dev
apt-get install -y libxi-dev
apt-get install -y libxrandr-dev
apt-get install -y libxrender-dev
apt-get install -y libqt4-dev
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


###############
## gnx-tools ##
###############
cd /tmp/
# Download DEB package
wget --no-check-certificate https://launchpad.net/~tbooth/+archive/ppa1/+files/gnx-tools_0.1%2B20120305-1_all.deb
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
wget --no-check-certificate http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.1.zip
unzip fastqc_v0.11.1.zip
mv FastQC 0.11.1
ln -s $install_dir/$tool_name/0.11.1 $install_dir/$tool_name/default
# Cleanup
rm fastqc_v0.11.1.zip
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
wget --no-check-certificate https://github.com/agordon/fastx_toolkit/releases/download/0.0.14/fastx_toolkit-0.0.14.tar.bz2
tar -xjvf fastx_toolkit-0.0.14.tar.bz2
# Compile
cd fastx_toolkit-0.0.14
./configure --prefix=$install_dir/$tool_name/0.0.14
make; make install
ln -s $install_dir/$tool_name/0.0.14 $install_dir/$tool_name/default
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
wget --no-check-certificate http://sourceforge.net/projects/picard/files/picard-tools/1.114/picard-tools-1.114.zip
unzip picard-tools-1.114.zip
mv picard-tools-1.114 1.114
ln -s $install_dir/$tool_name/1.114 $install_dir/$tool_name/default
# Cleanup
rm picard-tools-1.114.zip
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
wget --no-check-certificate http://sourceforge.net/projects/bowtie-bio/files/bowtie/1.0.1/bowtie-1.0.1-src.zip
unzip bowtie-1.0.1-src.zip
# Compile
mv bowtie-1.0.1 1.0.1
cd 1.0.1/
make
ln -s $install_dir/$tool_name/1.0.1 $install_dir/$tool_name/default
# Cleanup
cd ../
rm bowtie-1.0.1-src.zip
####################


##############
## Bowtie 2 ##
##############
tool_name='Bowtie2'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget --no-check-certificate http://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.3/bowtie2-2.2.3-source.zip
unzip bowtie2-2.2.3-source.zip
# Compile
mv bowtie2-2.2.3 2.2.3
cd 2.2.3/
make
ln -s $install_dir/$tool_name/2.2.3 $install_dir/$tool_name/default
# Cleanup
cd ../
rm bowtie2-2.2.3-source.zip
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
wget --no-check-certificate http://sourceforge.net/projects/samtools/files/samtools/0.1.18/samtools-0.1.18.tar.bz2
tar -xjvf samtools-0.1.18.tar.bz2
# Compile
mv samtools-0.1.18 0.1.18
cd 0.1.18/
make
ln -s $install_dir/$tool_name/0.1.18 $install_dir/$tool_name/default
# Cleanup
cd ../
rm samtools-0.1.18.tar.bz2
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
wget --no-check-certificate https://github.com/arq5x/bedtools2/releases/download/v2.20.1/bedtools-2.20.1.tar.gz
tar -xzvf bedtools-2.20.1.tar.gz
# Compile
mv bedtools2-2.20.1 2.20.1
cd 2.20.1
make
ln -s $install_dir/$tool_name/2.20.1 $install_dir/$tool_name/default
# Cleanup
cd ../
rm bedtools-2.20.1.tar.gz
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
wget --no-check-certificate http://hgdownload.cse.ucsc.edu/admin/exe/userApps.src.tgz
tar -xzvf userApps.src.tgz
# Compile
cd userApps/
make
ln -s $install_dir/$tool_name/userApps $install_dir/$tool_name/default
# Cleanup
cd ../
rm userApps.src.tgz
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
wget --no-check-certificate https://www.ebi.ac.uk/~zerbino/velvet/velvet_1.2.10.tgz
tar -xzvf velvet_1.2.10.tgz
# Compile
mv velvet_1.2.10 1.2.10
cd 1.2.10
make 'MAXKMERLENGTH=59' 'LONGSEQUENCES=1' 'OPENMP=1'
make 'MAXKMERLENGTH=59' 'LONGSEQUENCES=1' 'OPENMP=1' color
make doc
ln -s $install_dir/$tool_name/1.2.10 $install_dir/$tool_name/default
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
wget --no-check-certificate https://github.com/taoliu/MACS/archive/v1.4.2.tar.gz
tar -xzvf v1.4.2.tar.gz
# Compile
cd MACS-1.4.2/
python setup.py install --prefix $install_dir/$tool_name/1.4.2
ln -s $install_dir/$tool_name/1.4.2 $install_dir/$tool_name/default
# Cleanup
cd ../
rm -r MACS-1.4.2
rm MACS-1.4.2-1.tar.gz
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
wget --no-check-certificate http://www.ebi.ac.uk/sites/ebi.ac.uk/files/groups/bertone/software/PeakAnalyzer_1.4.tar.gz
tar -xzvf PeakAnalyzer_1.4.tar.gz
mv PeakAnalyzer_1.4 1.4
ln -s $install_dir/$tool_name/1.4 $install_dir/$tool_name/default
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
wget --no-check-certificate http://ccb.jhu.edu/software/tophat/downloads/tophat-1.4.1.tar.gz
tar -xzvf tophat-1.4.1.tar.gz
# Compile
cd tophat-1.4.1
./configure --with-bam=$install_dir/SAMtools/default --prefix=$install_dir/$tool_name/1.4.1
make all
make install
ln -s $install_dir/$tool_name/1.4.1 $install_dir/$tool_name/default
# Cleanup
cd ../
rm -r tophat-1.4.1
rm tophat-1.4.1.tar.gz
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
wget --no-check-certificate http://cufflinks.cbcb.umd.edu/downloads/cufflinks-2.2.1.tar.gz
tar -xzvf cufflinks-2.2.1.tar.gz
# Compile
cd cufflinks-2.2.1/
./configure --prefix=/tools/Cufflinks/2.2.1 --with-bam=/tools/SAMtools/0.1.18/ --with-boost=/usr/
make all
make install
ln -s $install_dir/$tool_name/2.2.1 $install_dir/$tool_name/default
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
wget --no-check-certificate http://www.broadinstitute.org/igv/projects/downloads/IGV_2.3.32.zip
unzip IGV_2.3.32.zip
mv IGV_2.3.32 2.3.32
ln -s $install_dir/$tool_name/2.3.32 $install_dir/$tool_name/default
# Cleanup
rm IGV_2.3.32.zip
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
wget --no-check-certificate http://www.broadinstitute.org/igv/projects/downloads/igvtools_2.3.32.zip
unzip igvtools_2.3.32.zip
ln -s $install_dir/$tool_name/2.3.32 $install_dir/$tool_name/default
mv IGVTools 2.3.32
# Cleanup
rm igvtools_2.3.32.zip
####################


#######
## R ##
#######
tool_name='R'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget --no-check-certificate http://cran.csiro.au/src/base/R-3/R-3.1.0.tar.gz
tar -xzvf R-3.1.0.tar.gz
# Compile
cd R-3.1.0/
./configure --prefix=/tools/R/3.1.0
make all
make install
ln -s $install_dir/$tool_name/3.1.0 $install_dir/$tool_name/default
# Cleanup
cd ../
rm -r R-3.1.0
rm R-3.1.0.tar.gz
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
wget --no-check-certificate http://sourceforge.net/projects/amos/files/amos/3.1.0/amos-3.1.0.tar.gz
tar -xzvf amos-3.1.0.tar.gz
cd amos-3.1.0/
./configure --prefix=$install_dir/$tool_name/3.1.0 --enable-minimus=no
make
make install
ln -s $install_dir/$tool_name/3.1.0 $install_dir/$tool_name/default
# Cleanup
cd ../
rm -r amos-3.1.0/
rm amos-3.1.0.tar.gz
####################


#################
## Setup Paths ##
#################
chown -R $owner.$owner $install_dir
echo "" >> /etc/bash.bashrc
echo "# BPA CSIRO NGS Tools" >> /etc/bash.bashrc
echo "alias gnx=/usr/bin/gnx-tools" >> /etc/bash.bashrc
echo "export LD_LIBRARY_PATH=/tools/Qt/qt-default/lib:\$LD_LIBRARY_PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/FastQC/default:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/FASTX-Toolkit/default/bin:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/Picard/default:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/Bowtie/default:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/Bowtie2/default:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/SAMtools/default:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/SAMtools/default/bcftools:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/SAMtools/default/misc:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/bedtools/default/bin:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/UCSCtools/userApps/bin:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/IGV/default:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/IGVTools/default:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/MACS/default/bin:\$PATH" >> /etc/bash.bashrc
echo "alias macs=/tools/MACS/default/bin/macs14" >> /etc/bash.bashrc
echo "export PYTHONPATH=/tools/MACS/default/lib/python2.7/site-packages:\$PYTHONPATH" >> /etc/bash.bashrc
echo "export PATH=/tools/TopHat/default/bin:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/Cufflinks/default/bin:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/Velvet/default:\$PATH" >> /etc/bash.bashrc
echo "alias velveth_long=/tools/Velvet/default/velveth" >> /etc/bash.bashrc
echo "alias velvetg_long=/tools/Velvet/default/velvetg" >> /etc/bash.bashrc
echo "export PATH=/tools/AMOS/default/bin:\$PATH" >> /etc/bash.bashrc
echo "export PATH=/tools/R/default/bin:\$PATH" >> /etc/bash.bashrc
