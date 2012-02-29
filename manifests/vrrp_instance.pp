# vrrp_instance.pp
#
# $Id$

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

    common::concatfilepart {
       "vrrp_instance_${name}":
           ensure  => present,
           manage  => true,
           content => template("keepalived/vrrp_instance.erb"),
           file    => "${system_etc_dir}/keepalived/keepalived.conf",
           require => Package["keepalived"];
    }

}
