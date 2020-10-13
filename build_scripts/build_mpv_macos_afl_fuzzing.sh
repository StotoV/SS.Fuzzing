#!/bin/bash

# set output dir
export BASE_DIR="/Users/tomstock/Documents/School/RU/Master/Software\ security/Assignments/Fuzzing"
export OUT_DIR="${BASE_DIR}/bin/"

# use the llvm compiler
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++

# set the ramdisk name
export VOLNAME=mpv-master

# and make it 1.5 GB
DISK_ID=$(hdid -nomount ram://4145728)
newfs_hfs -v ${VOLNAME} ${DISK_ID}
diskutil mount ${DISK_ID}

# set up shortcuts
export TARGET="/Volumes/${VOLNAME}/"
export CMPL="/Volumes/${VOLNAME}/compile"
export PATH=${TARGET}/bin:$PATH

# extend the python modules path
export PYTHONPATH="${TARGET}/lib/python2.7/site-packages/"

# set up the directories
mkdir -p ${CMPL}

# next, yasm
# should work with yasm-1.3.0.tar.gz
cd ${CMPL}
curl -LOs http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar xzpf ${CMPL}/yasm-1.3.0.tar.gz
cd yasm-*
./configure --prefix=${TARGET} && make -j 8 && make install

# next, pkg-config
# should work with pkg-config-0.29.1.tar.gz
cd ${CMPL}
curl -LOs https://pkg-config.freedesktop.org/releases/pkg-config-0.29.2.tar.gz
tar xzpf ${CMPL}/pkg-config-0.29.2.tar.gz
cd pkg-config*
export LDFLAGS="-framework Foundation -framework Cocoa"
./configure --prefix=${TARGET} --with-pc-path=${TARGET}/lib/pkgconfig --with-internal-glib && make -j 8 && make install
unset LDFLAGS

# building libressl
# should work with libressl-2.4.2.tar.gz
puts "Building libressl"
cd ${CMPL}
curl -LOs http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-2.1.3.tar.gz
tar xzpf ${CMPL}/libressl-2.1.3.tar.gz
cd libressl*
./configure --prefix=${TARGET} --enable-static --disable-shared && make -j 8 && make -s install

# building openssl
cd ${CMPL}
curl -LOs https://www.openssl.org/source/openssl-1.1.1h.tar.gz
tar xzpf ${CMPL}/openssl-1.1.1h.tar.gz
cd openssl*
./Configure --prefix=${TARGET} --openssldir=${TARGET} && make -j 8 && make -s install

# get ffmpeg
# technically, I could simply build a full blown ffmpeg with third party libraries
# but as they are mostly used for encoding and mpv is a media player
# there is no real need to do it. But you could, if you wanted to :-)
cd ${CMPL}
curl -LOs http://www.ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar xjpf ffmpeg-snapshot.tar.bz2
cd ffmpeg
./configure --prefix=${TARGET} \
--extra-cflags="-I${TARGET}/include" \
--extra-ldflags="-L${TARGET}/lib" \
--enable-openssl \
--enable-static \
--disable-shared \
--disable-doc && make -j 8 && make install

# check if build was successful
if [ ! -e $TARGET/bin/ffmpeg ]
then
echo "Build failed (ffmpeg). KABOOM"
exit 1
fi

# and build mpv
# clone from git so the version will be set
git clone https://github.com/mpv-player/mpv.git
cd mpv

# Set AFL compilers
export CC=/usr/local/Cellar/afl-fuzz/2.57b/bin/afl-gcc
export CXX=/usr/local/Cellar/afl-fuzz/2.57b/bin/afl-g++

# And mpv just had to use yet another different build system
# people just have too much time reinventing the wheel....
# This time, it is some python hell called 'was'

./bootstrap.py

# Without this the configure line will(!) fail
export PKG_CONFIG=pkg-config

# something broke finding "ar", this is a crude way to fix it
sed '/ctx.find_program.ar/d' -i wscript

./waf configure --prefix=${TARGET} --disable-libass-osd --disable-libass

./waf build
./waf install

# check if build was successful
if [ ! -e $TARGET/bin/mpv ]
then
echo "Build failed. KABOOM"
exit 1
fi

# debug
# bash

# copy to local directory
cp ${TARGET}/bin/mpv ${OUT_DIR}
# cp ${TARGET}/share/man/man1/mpv.1 $HOME/.man/man1/

# wipe the compilation tree
cd ${TARGET} && rm -rf include
cd ${TARGET} && rm -rf lib
cd ${TARGET} && rm -rf compile

# create the disk image
hdiutil create -size 300m -volname ${VOLNAME} -srcfolder /Volumes/${VOLNAME} $HOME/Downloads/${VOLNAME}

# eject the ram disk
cd $HOME
diskutil eject /Volumes/${VOLNAME}
