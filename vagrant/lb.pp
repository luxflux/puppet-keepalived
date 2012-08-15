node default {
  class {
    'keepalived':
      email => "root@example.org";
  }

  keepalived::vrrp_sync_group {
    'test':
      members => ['gw'];
  }

  keepalived::vrrp_instance {
    "gw":
      kind              => "MASTER",
      interface         => "eth0",
      password          => "ThisIsAPassword",
      virtual_router_id => 1,
      virtual_addresses => [
                            "10.10.10.1 dev eth1",
                            "10.12.12.1 dev eth0",
                            "ffff::1 dev eth1"
                           ];
  }

  keepalived::virtual_server {
    '10.10.10.1':
      port     => 25,
      lb_kind  => 'DR',
      protocol => 'TCP';
  }

  keepalived::real_server {
    '10.10.10.2':
      port                => 25,
      check_type          => 'SMTP',
      virtual_server_name => '10.10.10.1',
      virtual_server_port => 25;
  }

}
