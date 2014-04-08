Multi PHP Version Tester
=======================

This is a vagrant box for testing application in multiple PHP version without putting extra efforts to setup.

Tested on
-------------
1. Host-OS   : Ubuntu 12.04 LTS
2. Guest-OS  : Ubuntu 12.04 Precise-64bit. 


How it works
------------
1. Your php source code is in `/var/www`
2. `/var/www` folder is shared by vagrant-box and vagrant box serve same folders via different subdomains
3. Vagrant box host 
    `53.local.dev` : PHP 5.3.27  version is served
    `55.local.dev` : PHP 5.4.23  version is served
    `55.local.dev` : PHP 5.5.7   version is served

Checks
---------
1. Mysql server running on HOST-OS should allow remote connections [ comment the line specifying `bind-address` in `/etc/mysql/my.cnf`]
2. Database User used in application must have privelleges while connecting from remote hosts. (Check privelleges using PMA)
3. On host machine add subdomain definition mentions in `<repo>/files/hosts` file.
4. You should use your `<HOST-OS>-IP-Address` in you application to connect to mysql server .


Setup
------
1. Clone this repo
2. Update `<repo>/Vagrantfile` for changes required
3. Run command `Vagrant up`
4. Update `/etc/hosts` on Host by adding contents of `<repo>/files/hosts`
5. Copy folder `<repo>/files/test` folder to `/var/www` and run [53|54|55].local.dev/php.php to test proper PHP version


Debugging
----------




Thats it.