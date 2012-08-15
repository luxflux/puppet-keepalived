define keepalived::vrrp_instance(
  $kind,
  $interface,
  $virtual_router_id = 10,
  $advert_int = 1,
  $password,
  $virtual_addresses
) {

  if($kind != "MASTER" and $kind != "BACKUP") {
      fail("${kind} is not allowed, only MASTER or BACKUP")
  }


  concat::fragment {
    "keepalived.vrrp_instance_${name}":
      content => template("keepalived/vrrp_instance.erb"),
      target  => '/etc/keepalived/keepalived.conf',
      order   => 03;
  }

}
