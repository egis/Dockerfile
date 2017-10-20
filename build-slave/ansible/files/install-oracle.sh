#!/bin/sh


set -e

FILENAME=jdk-linux-amd64.tar.gz
PARTNER_URL=`curl -s http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html | grep -ioE "http://download.oracle.com/otn-pub/java/jdk/.*?/jdk-8u.*?-linux-x64.tar.gz" | tail -1`
JAVA_VERSION=`echo $(basename $PARTNER_URL) | cut -d- -f2`
J_DIR=jdk1.8.0_$(echo $JAVA_VERSION | cut -du -f2)
J_INSTALL_DIR=/usr/lib/jvm/java-8-oracle

mkdir -p /usr/lib/jvm
#without this, an error is displayed if the folder doesn't exist:
mkdir -p /usr/lib/mozilla/plugins

. /usr/share/debconf/confmodule
cd /usr/lib/jvm
wget --continue --no-check-certificate -O $FILENAME --header "Cookie: oraclelicense=a" $PARTNER_URL
tar -zxvf $FILENAME
if [ -e $J_INSTALL_DIR ]; then
    rm -rf $J_INSTALL_DIR
fi
mv $J_DIR $J_INSTALL_DIR
if [ -e  /usr/lib/jvm/default-java ]; then
    rm  /usr/lib/jvm/default-java
fi

ln -s  $J_INSTALL_DIR /usr/lib/jvm/default-java

for b in java javac jstack jstat jdb jps keytool; do
    f=$J_INSTALL_DIR/bin/$b
    name=`basename $f`;
    if [ -e /usr/bin/$name ]; then
        rm /usr/bin/$name
    fi
    ln -s  $f /usr/bin/$name
done


# Use cacerts form ca-certificates-java if it's installed:
if [ -e /etc/ssl/certs/java/cacerts ]; then
  cd /usr/lib/jvm/java-8-oracle/jre/lib/security
  mv cacerts cacerts.original
  ln -s /etc/ssl/certs/java/cacerts .
fi