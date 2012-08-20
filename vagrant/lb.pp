node lb {
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
      virtual_addresses => ["10.10.10.10 dev eth0"];
  }

  keepalived::virtual_server {
    '10.10.10.10':
      port     => 25,
      lb_kind  => 'DR',
      protocol => 'TCP';
  }

}
