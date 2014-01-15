Multi PHP Version Tester
=======================

This is a vagrant box for testing application in multiple PHP version without putting extra efforts to setup.

Tested on
-------------
1. Host-OS   : Ubuntu 12.04 LTS
2. Guest-OS  : Ubuntu 12.04 Precise-64bit. 


How it works
------------
1. Your php source code is `/var/www`
2. `/var/www` folder is shared by vagrant-box and vagrant box serve same folders via different subdomains
3. Vagrant box host 
    `53.local.dev` : PHP 5.3.27  version is served
    `55.local.dev` : PHP 5.4.23  version is served
    `55.local.dev` : PHP 5.5.7   version is served
4. Vagrant box runs mysql-proxy, so php application running via box can connect to original mysql-servering running on host-os. In this way same database is used by application.


Checks
---------
1. PHP Application must be connecting to mysql server via `127.0.0.1:3306` (not by localhost)
2. PHP application uses `mysqli` 
3. Mysql server running on HOST-OS should allow remote connections [ comment the line specifying `bind-address` in `/etc/mysql/my.cnf`
4. Database User used in application must have privelleges while connecting from remote hosts. (Check privelleges using PMA)
5. On host machine add subdomain definition mentions in `<repo>/files/hosts` file.
6. You should update you `<HOST-OS>-IP-Address` in `<repo>/files/mysql-proxy.conf` file.
7. Project uses locally hosted vagrant box image, you need to update box-image localtion `config.vm.box_url`in `Vagrantfile`.
8. Project uses locally hosted ubuntu apt-server proxy to speed-up the installation, you should remove line `config.vm.provision :shell, :inline => 'echo \'Acquire::http::proxy "http://10.0.0.31:3142";\' > /etc/apt/apt.conf.d/01proxy'`from `Vagrantfile` if you dont have it.

Setup
------
