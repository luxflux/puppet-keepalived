node mx {

  sysctl::directive {
    'net.ipv4.conf.all.ARP_ignore':
      value => 1;

    'net.ipv4.conf.all.ARP_announce':
      value => 2;
  }

  @@keepalived::real_server {
    '10.10.10.20':
      port                => 25,
      check_type          => 'SMTP',
      virtual_server_name => '10.10.10.10',
      virtual_server_port => 25;
  }

  package {
    'postfix':
      ensure => installed;
  }

  exec {
    'add virtual ip':
      command => '/sbin/ip addr add 10.10.10.10/32 dev lo',
      unless  => '/sbin/ip addr ls dev lo | grep 10.10.10.10';
  }

}
