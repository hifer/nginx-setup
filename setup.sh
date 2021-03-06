#!/bin/bash
# shell script to install nginx1.8.0
# version 1.0 
# auth:lvhifer@163.com 2016/01/09

if [ ! -f "master.zip" ]; then
 echo "now downloading setup files,this may spend few minutes"
 wget -c https://github.com/hifer/nginx-setup/archive/master.zip > /dev/null 2>&1
 unzip master.zip > /dev/null 2>&1
 cd nginx-setup-master
 #yum
 yum install -y zlib-devel  > /dev/null 2>&1
 yum install -y gcc gcc-c++  > /dev/null 2>&1
else
 mv master.zip master.zip.bak
 echo "now downloading setup files,this may spend few minutes"
 wget -c https://github.com/hifer/nginx-setup/archive/master.zip > /dev/null 2>&1
 unzip master.zip > /dev/null 2>&1
 cd nginx-setup-master
 #yum
 yum install -y zlib-devel  > /dev/null 2>&1
 yum install -y gcc gcc-c++  > /dev/null 2>&1
fi


date=`date +%Y-%m-%d`
basePath=$(cd "$(dirname "$0")"; pwd)
setPath=/usr/local
pcrePath=$setPath/pcre-8.38
nginxPath=$setPath/nginx
nginxStatic=$setPath/static

#install pcre
cd $basePath
cp pcre-8.38.tar.gz $setPath/.
if [ -d "$pcrePath" ]; then
 rm -rf $pcrePath
fi
cd $setPath
tar zxvf pcre-8.38.tar.gz
sleep 1
rm -rf pcre-8.38.tar.gz
cd pcre-8.38
 ./configure --prefix=$pcrePath
  if [ $? == 0 ];then
   make && make install 
   sleep 3 
   echo "pcre-8.38 install sucessfull!!!"
  else
   echo "pcre-8.38 install fail,please check reason..."
   exit 1
  fi


#install nginx
cd $basePath
cp nginx-1.8.0.tar.gz $setPath/.
if [ -d "$nginxPath" ]; then
 rm -rf $nginxPath
fi
cd $setPath
tar zxvf nginx-1.8.0.tar.gz
sleep 1
rm -rf nginx-1.8.0.tar.gz
cd nginx-1.8.0
if [ -d "$nginxPath" ]; then
 rm -rf $nginxPath
fi
 ./configure --prefix=$nginxPath --with-pcre=$pcrePath
  if [ $? == 0 ];then
   make && make install
   sleep 3
   echo "nginx install sucessfull!!!"
  else
   echo "nginx install fail,please check reason..."
   exit 1
  fi

#nginx.conf
cd $basePath
\cp nginx.conf $nginxPath/conf/.
\cp nginx /etc/init.d/.
chmod 755 /etc/init.d/nginx

if [ -d "$nginxStatic" ]; then
 rm -rf $nginxStatic.$date
 mv $nginxStatic $nginxStatic.$date
fi
mkdir -p $nginxStatic
\cp index.html $nginxStatic


cd $basePath
rm -rf nginx-1.8.0.tar.gz pcre-8.38.tar.gz


