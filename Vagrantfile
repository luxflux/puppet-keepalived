# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  # config.vm.network :hostonly, "192.168.33.10"

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
  # config.vm.network :bridged

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.forward_port 80, 8080

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file precise64.pp in the manifests_path directory.
  #
  # An example Puppet manifest to provision the message of the day:
  #
  # # group { "puppet":
  # #   ensure => "present",
  # # }
  # #
  # # File { owner => 0, group => 0, mode => 0644 }
  # #
  # # file { '/etc/motd':
  # #   content => "Welcome to your Vagrant-built virtual machine!
  # #               Managed by Puppet.\n"
  # # }
  #

  config.vm.share_folder 'puppet-conf', '/tmp/puppet-conf', 'vagrant/puppet-conf'

  config.vm.provision :shell, :inline => "apt-get install puppet libsqlite3-ruby libactiverecord-ruby -y"
  config.vm.provision :shell, :inline => "rm /etc/puppet/puppet.conf && ln -s /tmp/puppet-conf/puppet.conf /etc/puppet/puppet.conf"

  config.vm.define :lb do |lb_config|
    lb_config.vm.forward_port 25, 2525

    lb_config.vm.network :hostonly, "10.10.10.11"

    lb_config.vm.provision :puppet, :module_path => '../' do |puppet|
      puppet.manifests_path = "vagrant"
      puppet.manifest_file  = "lb.pp"
    end
  end

  config.vm.define :mx do |mx_config|

    mx_config.vm.network :hostonly, "10.10.10.20"

    mx_config.vm.provision :puppet, :module_path => '../' do |puppet|
      puppet.manifests_path = "vagrant"
      puppet.manifest_file  = "mx.pp"
    end
  end

end
