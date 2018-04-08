URL='http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jre-8u162-linux-x64.rpm'

mkdir -p /tmp/pkg
cd /tmp/pkg

yum install wget -y

wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" ${URL}

#get filename in a url:https://www.cnblogs.com/nzbbody/p/4391802.html
FILE_NAME=${URL##*/}

rpm -ivh ${FILE_NAME}