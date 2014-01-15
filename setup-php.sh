#!/bin/bash

version=$1

echo "Setting up PHP version $version"
# splits the version

a=( ${version//./ } )        
RB_PHP_VERSION_X_Y_Z="${a[0]}.${a[1]}.${a[2]}"
RB_PHP_VERSION_XY="${a[0]}${a[1]}"
RB_PHP_VERSION_X="${a[0]}"

echo "RB_PHP_VERSION_X_Y_Z = $RB_PHP_VERSION_X_Y_Z"
echo "RB_PHP_VERSION_XY = $RB_PHP_VERSION_XY"
echo "RB_PHP_VERSION_X = $RB_PHP_VERSION_X"

# compile php version
cd /usr/local/php/src
sudo ./compile.sh $RB_PHP_VERSION_X_Y_Z  > /vagrant/logs/php-$version.log
sudo /usr/local/php/inst/php-$version/bin/php-cgi -v


# created temporary files of /vagrant/files/tmpl to /vagrant/tmp
sudo cp -fR /vagrant/files/tmpl /vagrant/tmp
for var in "RB_PHP_VERSION_X_Y_Z" "RB_PHP_VERSION_XY" "RB_PHP_VERSION_X"
do	
	value=${!var}
	echo "Replacing var <$var> to <$value>"
	
	find /vagrant/tmp -type f -exec sed -i "s/$var/$value/g" {} \;
done


# setup cgi-bin
sudo cp /vagrant/tmp/php.fcgi /usr/lib/cgi-bin/php$RB_PHP_VERSION_XY.fcgi
sudo chown -R www-data:www-data /usr/lib/cgi-bin/php$RB_PHP_VERSION_XY.fcgi
sudo chmod +x /usr/lib/cgi-bin/php$RB_PHP_VERSION_XY.fcgi

#virtual hosts
sudo cp /vagrant/tmp/virtualhost /etc/apache2/sites-available/$RB_PHP_VERSION_XY.local.dev
sudo ln -s /etc/apache2/sites-available/$RB_PHP_VERSION_XY.local.dev  /etc/apache2/sites-enabled/$RB_PHP_VERSION_XY.local.dev

# remove temporary folder
sudo rm -fR /vagrant/tmp

# restart for effect
sudo service apache2 restart

#
echo "PHP Installed $version"
