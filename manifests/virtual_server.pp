# == Define: keepalived::virtual_server
#
# Add a virtual host definition to the keepalived configuration.
#
# === Parameters
#
# [*sorry_server*]
#   Server to be added to the pool if all real servers are down.
#
# [*persistence_timeout*]
#   Specify a timeout value for persistent connections. (Default to: 60)
#
# [*delay_loop*]
#   Specify in seconds the interval between check. (Default to: 10)
#
# [*lb_algo*]
#   Select a specific scheduler (rr|wrr|lc|wlc...). (Default to: wrr) 
#
# [*lb_kind*]
#   Select a specific forwarding method (NAT|DR|TUN)
#
# [*port*]
#   Specify the port of the virtual server.
#
# [*protocol*]
#   Specify the protocol kind (TCP|UDP)
#
# [*ip*]
#   Specify IP Address of the virtual server.
#
# [*bindto*]
#   Specify IP Address to propagate to the real servers as bindto address.
#
# [*virtualhost*]
#   Specify a HTTP virtualhost to use for HTTP|SSL_GET
#
# === Examples
#
#   keepalived::virtual_server {  'example.com':
#     ip                  => '93.184.216.119',
#     port                => 80,
#     lb_kind             => 'NAT',
#     lb_algo             => 'wrr',
#     protocol            => 'TCP',
#     delay_loop          => '5',
#     sorry_server        => '93.184.216.118 80',
#     persistence_timeout => 0;
#    }
#   }
#
# === Authors
#
# Raffael Schmid <raffael@yux.ch>
# Tobias Brunner <tobias.brunner@nine.ch>
# Marius Rieder <marius.rieder@nine.ch>
#
# === Copyright
#
# Copyright 2012 Raffael Schmid <raffael@yux.ch>
#
define keepalived::virtual_server(
  $sorry_server = false,
  $persistence_timeout = '60',
  $delay_loop = 10,
  $lb_algo = 'wrr',
  $lb_kind,
  $port,
  $protocol,
  $ip,
  $bindto = false,
  $virtualhost = undef,
) {

  concat {
    "/etc/keepalived/concat/virtual_server.${ip}:${port}":
      notify  => Exec['concat_keepalived.conf'];
  }

  concat::fragment {
    "keepalived.virtual_server.${ip}.${port}.header":
      content => template("keepalived/virtual_server.header.erb"),
      target  => "/etc/keepalived/concat/virtual_server.${ip}:${port}",
      order   => 01;

    "keepalived.virtual_server.${ip}.${port}.footer":
      content => template("keepalived/virtual_server.footer.erb"),
      target  => "/etc/keepalived/concat/virtual_server.${ip}:${port}",
      order   => 99;
  }

  if $bindto {
    Keepalived::Real_server <<| virtual_server_name == $name |>> {
      bindto => $bindto
    }
  } else {
    Keepalived::Real_server <<| virtual_server_name == $name |>>
  }
}
