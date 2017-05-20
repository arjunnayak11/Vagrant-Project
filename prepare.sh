#!/bin/bash
MYSQL_PASSWD='12345'
MYSQL_DBNAME='kgecedu'
MYSQL_USER='kgec'
if [ -f /etc/redhat-release ]; then
	sudo  yum update
fi

if [ -f /etc/lsb-release ]; then
	echo "Update Disro"
	sudo  apt-get update

	echo "Install PHP and Apache2"
        sudo apt-get install php5 apache2
	echo "copy php info"
        cp index.php /var/www/html/
	echo "Secure SSH Access"
        cp sshd_config  /etc/ssh/sshd_config
        
        echo "check mysql  is present or not"
         if [ ! -f /etc/mysql/my.cnf ] ; then
              echo "install  mysql if not installed"
              sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_PASSWD"
              sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_PASSWD"
              sudo apt-get install mysql-server -y
              sudo apt-get  install  mysql-client  -y 
        fi 
       echo "create database if not exist"
       Q1="CREATE DATABASE IF NOT EXISTS $MYSQL_DBNAME;"
      # echo "create user if not exist"
      # Q4="CREATE USER $MYSQL_USER IDENTIFIED BY $MYSQL_PASSWD;"
      # echo "Grant privileges to the user on the database"
      # Q2="GRANT ALL ON '*.*' TO "$MYSQL_USER"@'$' IDENTIFIED BY $MYSQL_PASSWD;"
      # Q3="FLUSH PRIVILEGES;"
      # SQL="${Q1}${Q4}${Q2}${Q3}"
       echo $SQL
       mysql -uroot -p$MYSQL_PASSWD  -e "$Q1"
       echo $?  

fi
