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
