#!/bin/bash
# shell script to install nginx1.8.0
# version 1.0 
# auth:lvhaif@minmetals.com 2016/01/09

date=`date +%Y-%m-%d`
basePath=$(cd "$(dirname "$0")"; pwd)
setPath=/usr/local
pcrePath=$setPath/pcre-8.38
nginxPath=$setPath/nginx
nginxStatic=$setPath/static

if [ ! -f "release-20160612.zip" ]; then
 echo "now downloading setup files,this may spend few minutes"
 wget -c https://github.com/hifer/nginx-setup/archive/release-20160612.zip > /dev/null 2>&1
 unzip release-20160612.zip > /dev/null 2>&1
 cd nginx-setup-release-20160612
else
 mv release-20160612.zip release-20160612.zip.bak
 echo "now downloading setup files,this may spend few minutes"
 wget -c https://github.com/hifer/nginx-setup/archive/release-20160612.zip > /dev/null 2>&1
 unzip release-20160612.zip > /dev/null 2>&1
 cd nginx-setup-release-20160612
fi


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

#start nginx
#service nginx restart
#$nginxPath/sbin/nginx -c $nginxPath/conf/nginx.conf

cd $basePath
rm -rf nginx-1.8.0.tar.gz pcre-8.38.tar.gz

#/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf

