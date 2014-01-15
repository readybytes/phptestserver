# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # Set box configuration
  config.vm.box = "precise64"
  config.vm.box_url = "http://10.0.0.91/intranet/downloads/vagrant/boxes/precise64.box"

  # Uncomment these lines to give the virtual machine more memory and "dual core cpu"
  config.vm.customize ["modifyvm", :id, "--memory", 512]
  config.vm.customize ["modifyvm", :id, "--cpus", 1]

  # Forward web port
  #config.vm.forward_port 80, 44580

  # Set share folder permissions to 777 so that apache can write files
  config.vm.share_folder("shared-code", "/var/www",          "/var/www",                 :extra => 'dmode=777,fmode=666')

  # Reuse Repos
  config.vm.share_folder("shared-repos", "/vobs",            "/vobs",                        :extra => 'dmode=777,fmode=666')

  # enable it by executing this command
  # ln -s -T ~/Dropbox /vobs/shared/dropbox
  # config.vm.share_folder("shared-dropbox", "/home/vagrant/Dropbox", "/vobs/shared/dropbox",        :extra => 'dmode=777,fmode=666')

  # Use Proxy to speedup
  config.vm.provision :shell, :inline => 'echo \'Acquire::http::proxy "http://10.0.0.31:3142";\' > /etc/apt/apt.conf.d/01proxy'

  # Assign this VM to a host-only network IP, allowing you to access it via the IP.
  config.vm.network :hostonly, "33.33.33.10"

  config.vm.provision :shell, :path => "setup.sh"

end

