# 说明：此方式在 centos7 执行成功

cd /opt

yum -y update 
yum -y install libstdc++ autoconf automake libtool autoconf-archive pkg-config gcc gcc-c++ make libjpeg-devel libpng-devel libtiff-devel zlib-devel


#Install AutoConf-Archive
# wget ftp://mirror.switch.ch/pool/4/mirror/epel/7/ppc64/a/autoconf-archive-2016.09.16-1.el7.noarch.rpm
# rpm -i autoconf-archive-2016.09.16-1.el7.noarch.rpm
wget http://mirror.centos.org/centos/7/os/x86_64/Packages/autoconf-archive-2017.03.21-1.el7.noarch.rpm
rpm -i autoconf-archive-2017.03.21-1.el7.noarch.rpm


#Install Leptonica from Source
wget http://www.leptonica.com/source/leptonica-1.75.3.tar.gz
tar -zxvf leptonica-1.75.3.tar.gz
cd leptonica-1.75.3
./autobuild
./configure
make
make install
cd ..

#Install Tesseract from Source
wget https://github.com/tesseract-ocr/tesseract/archive/3.05.01.tar.gz
tar -zxvf 3.05.01.tar.gz
cd tesseract-3.05.01
./autogen.sh
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig LIBLEPT_HEADERSDIR=/usr/local/include ./configure --with-extra-includes=/usr/local/include --with-extra-libraries=/usr/local/lib
LDFLAGS="-L/usr/local/lib" CFLAGS="-I/usr/local/include" make
make install
ldconfig
cd ..

#Download and install tesseract language files
wget https://github.com/tesseract-ocr/tessdata/raw/3.04.00/ben.traineddata
wget https://github.com/tesseract-ocr/tessdata/raw/3.04.00/eng.traineddata
wget https://github.com/tesseract-ocr/tessdata/raw/3.04.00/hin.traineddata
wget https://github.com/tesseract-ocr/tessdata/raw/3.04.00/tha.traineddata
wget https://github.com/tesseract-ocr/tessdata/raw/3.04.00/osd.traineddata
mv *.traineddata /usr/local/share/tessdata

#Download Hindi Cube data
wget https://github.com/tesseract-ocr/tessdata/raw/3.04.00/hin.cube.bigrams
wget https://github.com/tesseract-ocr/tessdata/raw/3.04.00/hin.cube.fold
wget https://github.com/tesseract-ocr/tessdata/raw/3.04.00/hin.cube.lm
wget https://github.com/tesseract-ocr/tessdata/raw/3.04.00/hin.cube.nn
wget https://github.com/tesseract-ocr/tessdata/raw/3.04.00/hin.cube.params
wget https://github.com/tesseract-ocr/tessdata/raw/3.04.00/hin.cube.word-freq
wget https://github.com/tesseract-ocr/tessdata/raw/3.04.00/hin.tesseract_cube.nn
mv hin.* /usr/local/share/tessdata

# cp /usr/local/lib/*.so.* /usr/lib64/
# 如果需要在linux上运行带tess4j的项目，需要将/usr/local/lib下相关的tesseract和leptonica的library（.so）的文件复制到 /usr/lib下
cp /usr/local/lib/*.so.* /usr/lib/
cp /usr/local/lib/*.so /usr/lib/

ln -s /opt/tesseract-3.05.01 /opt/tesseract-latest
