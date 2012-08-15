# vrrp_sync_group.pp
#
# $Id$

define keepalived::vrrp_sync_group(
  $members
) {

  concat::fragment {
    "keepalived.vrrp_sync_group_${name}":
      content => template("keepalived/vrrp_sync_group.erb"),
      target  => '/etc/keepalived/keepalived.conf',
      order   => 02;
  }

}
