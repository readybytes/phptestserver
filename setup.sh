# refresh ubuntu repo
sudo apt-get update

# Indian timezone.
echo "Asia/Kolkata" | sudo tee /etc/timezone
sudo dpkg-reconfigure --frontend noninteractive tzdata

# Additional utils
sudo apt-get -y -q install bc unzip curl git-core

# Web server
sudo apt-get install -y -q apache2 apache2-mpm-prefork apache2-prefork-dev apache2-utils apache2.2-common 
sudo a2enmod rewrite

#mysql proxy to connect server
sudo apt-get install -y -q mysql-client mysql-client-5.5 mysql-common libmcrypt-dev curl openssl mysql-proxy php5-mysqlnd

#sudo apt-get build-dep -y php5

sudo apt-get install -y -q build-essential libcurl4-openssl-dev libmysqlclient-dev libreadline-dev libzip-dev libxslt1-dev libicu-dev libmcrypt-dev libmhash-dev libpcre3-dev libjpeg-dev libpng12-dev libfreetype6-dev libbz2-dev libxpm-dev libxml2-dev libpcre3-dev libbz2-dev libcurl4-openssl-dev libdb4.8-dev libjpeg-dev libpng12-dev libxpm-dev libfreetype6-dev libmysqlclient-dev libt1-dev libgd2-xpm-dev libgmp-dev libsasl2-dev libmhash-dev unixodbc-dev freetds-dev libpspell-dev libsnmp-dev libtidy-dev libxslt1-dev libmcrypt-dev

# apache fastcgi setup
sudo a2dismod php5
sudo apt-get install -y -q libapache2-mod-fastcgi apache2-suexec
sudo a2enmod fastcgi actions suexec


# setup phpfarm
cd /usr/local
sudo mkdir php
cd  php
sudo chown -R vagrant:vagrant .
git clone git://git.code.sf.net/p/phpfarm/code .
cd src/

#set compilation options
cp -f /vagrant/files/custom-options* /usr/local/php/src/
cp -f /vagrant/files/php-bzips/*.bz2 /usr/local/php/src/bzips/

# setup cgi-bin
sudo mkdir /usr/lib/cgi-bin
sudo cp -f /vagrant/files/cgi-bin/*.fcgi /usr/lib/cgi-bin/
sudo chown -R www-data:www-data /usr/lib/cgi-bin
sudo chmod +x /usr/lib/cgi-bin/*.fcgi

# apache configuration 
sudo a2enmod fastcgi actions suexec
sudo cp /vagrant/files/fastcgi.conf /etc/apache2/mods-enabled/fastcgi.conf

#virtual hosts
sudo rm /etc/apache2/sites-enabled/000-default

# compile and add php
sudo bash /vagrant/setup-php.sh 5.3.27
sudo bash /vagrant/setup-php.sh 5.4.23
sudo bash /vagrant/setup-php.sh 5.5.7

#setup mysql proxy
sudo touch ~/mysql-proxy.log
sudo cp /vagrant/files/mysql-proxy.cnf /home/vagrant/mysql-proxy.cnf
sudo chmod  0660 /home/vagrant/mysql-proxy.cnf 

# start proxy, also add itto autostart
sudo mysql-proxy --defaults-file=/home/vagrant/mysql-proxy.cnf

# restart for effect
sudo service apache2 restart

# copy downloaded zips to host machine
sudo cp -f /usr/local/php/src/bzips/*.bz2 /vagrant/files/php-bzips/

