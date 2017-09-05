##Drupal 8##

yum install httpd -y
systemctl start httpd
systemctl enable httpd
wget http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm
yum localinstall mysql57-community-release-el7-7.noarch.rpm -y
yum repolist enabled | grep "mysql.*-community.*"
yum install mysql-community-server -y
yum-config-manager --disable mysql57-community -y
yum-config-manager --enable mysql56-community -y
service mysqld start
service mysqld status
mysql --version
#grep 'temporary password' /var/log/mysqld.log
password=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $11}')
mysqladmin --user=root --password="$password" password B1o@dmin@ll0w
#yum update mysql-server
sudo yum install epel-release -y
rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum -y install yum-utils -y
yum update -y
yum-config-manager --enable remi-php71
yum -y install php php-opcache -y
yum install yum install gd gd-devel php-gd -y
yum install php-mysql -y
wget http://www.openssl.org/source/openssl-1.0.0.tar.gz
tar -xvzf openssl-1.0.0.tar.gz
cd openssl-1.0.0
./Configure && make && make install
service httpd restart
php -v
systemctl restart httpd
yum install wget gzip -y
wget -c https://ftp.drupal.org/files/projects/drupal-8.2.6.tar.gz
tar -zxvf drupal-8.2.6.tar.gz
mv drupal-8.2.6 /var/www/html/drupal
cd /var/www/html/drupal/sites/default/
cp default.settings.php settings.php
chown -R apache:apache /var/www/html/drupal/
#chcon -R -t httpd_sys_content_rw_t /var/www/html/drupal/sites/
dbusername="root"
dbpass="B1o@dmin@ll0w"
#echo "SET PASSWORD = PASSWORD('B1o@dmin@ll0w');" mysql -u $dbusername -p$password
echo "create database drupal;" |  mysql -u $dbusername -p$dbpass
echo "GRANT ALL ON drupal.* TO 'root'@'localhost' IDENTIFIED BY '$dbpass';" | mysql -u $dbusername -p$dbpass
echo "FLUSH PRIVILEGES;" |  mysql -u $dbusername -p$dbpass
echo "EXIT;" | mysql -u $dbusername -p$dbpass
service httpd restart
echo "Drupal on Cento7 installationtion sucessfully completed"