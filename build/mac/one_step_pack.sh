#/bin/bash

#git fetch --all;
#git reset --hard origin/release/1.0.0.0
#git reset --hard origin/develop

DATE=$(date +%Y_%m%d_%H%M)

cd ../../
rm -rf pack/
echo 'make clean'
make clean

echo "make clean build"
make clean_build


#update git

version=`git log |grep commit |head -1`
echo 'version: ' + $version

#get shortest hash
v=${version:7:7}

#make 
make chain_version=$v

mkdir -p pack
cd pack/
rm -rf bubichain/ 
mkdir bubichain
mkdir bubichain/config
mkdir bubichain/data
mkdir bubichain/jslib
mkdir bubichain/bin
mkdir bubichain/log
mkdir bubichain/coredump
cp ../build/win32/jslib/jslint.js bubichain/jslib/
cp ../build/win32/config/config-mainnet.json bubichain/config/
cp ../build/win32/config/config-testnet.json bubichain/config/
cp ../build/win32/config/config-single.json  bubichain/config/
cp ../build/win32/config/ReadMe.txt  bubichain/config/
cp ../bin/chain bubichain/bin/
cp ../src/3rd/v8_target/mac/*.bin bubichain/bin/
cp ../src/3rd/v8_target/mac/*.dat bubichain/bin/

tar czvf bubichain-mac-$DATE-$v.tar.gz bubichain/
rm -rf bubichain/ 

echo "build ok...."



