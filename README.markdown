# Keepalived puppet module

Module to manage keepalived on Debian/Ubuntu.

## Example

    class {
      "keepalived":
        email => "root@example.com"; # array also allowed
    }

    keepalived::vrrp_sync_group {
      "yuxCluster":
        members => [ "gw" ];
    }

    keepalived::vrrp_instance {
      "gw":
        kind              => "MASTER",
        interface         => "eth1",
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


