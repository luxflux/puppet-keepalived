# == Define: keepalived::vrrp_sync_group
#
# Add a vrrp_sync_group to the keepalived configuration.
#
# === Parameters
#
# [*name*]
#   Name of the vrrp sync group.
#
# [*members*]
#   Stecify a array of vrrpt sync group member instances.
#
# === Examples
#
#   keepalived::vrrp_sync_group { 'EXAMPLE_SYNC_GROUP':
#     memvers => ['EXAMPLE_WEB', 'EXAMPLE_WEB2']
#   }
#
#   keepalived::vrrp_instance { 'EXAMPLE_WEB':
#     kind              => 'MASTER',
#     interface         => 'eth0',
#     password          => 'EJ7aP6OteeN6Rin',
#     virtual_router_id => 23,
#     virtual_addresses => ['93.184.216.119/32 dev eth0'];
#   }
#
#   keepalived::vrrp_instance { 'EXAMPLE_WEB2':
#     kind              => 'MASTER',
#     interface         => 'eth0',
#     password          => 'EJ7aP6OteeN6Rin',
#     virtual_router_id => 24,
#     virtual_addresses => ['93.184.216.120/32 dev eth0'];
#   }
#
# === Authors
#
# Raffael Schmid <raffael@yux.ch>
#
# === Copyright
#
# Copyright 2012 Raffael Schmid <raffael@yux.ch>
#
define keepalived::vrrp_sync_group(
  $members
) {

  concat::fragment {
    "keepalived.vrrp_sync_group_${name}":
      content => template("keepalived/vrrp_sync_group.erb"),
      target  => '/etc/keepalived/concat/top',
      order   => 02;
  }

}
