# == Define: keepalived::vrrp_instance
#
# Add a vrrp_instance to the keepalived configuration.
#
# === Parameters
#
# [*name*]
#   Name of the vrrp instance.
#
# [*kind*]
#   Specify the instance state in standard use.
#
# [*interface*]
#   Specify the network interface for the instance to run.
#
# [*virtual_router_id*]
#   Specify to which VRRP router id the instance belong. (Default to: 10)
#
# [*priority*]
#   Specify the instance priority in the VRRP router. (Default to undef)
#
# [*advert_int*]
#   Specify the advertisement interval in second. (Default to: 1)
#
# [*password*]
#   Specify the password string to use as VRRP authentication.
#
# [*virtual_addresses*]
#   Specify the list of IP addresses of the vrrp instance.
#
# [*notify_master*]
#   Specify a shell script to be executed during transition to master state.
#
# [*notify_backup*]
#   Specify a shell script to be executed during transition to backup state.
#
# [*notify_fault*]
#   Specify a shell script to be executed during transition to fault state.
#
# [*notify_all*]
#   Specify a shell script to be executed during all transitions.
#  
# [*smtp_alert*]
#   Activate the SMTP notification for MASTER state transition. (Default to: false)
#
# [*track_script*]
#  Specify a shell script to be executed as a state check.
#
# === Examples
#
#   keepalived::vrrp_instance { 'EXAMPLE_WEB':
#     kind              => 'MASTER',
#     interface         => 'eth0',
#     password          => 'EJ7aP6OteeN6Rin',
#     virtual_router_id => 23,
#     virtual_addresses => ['93.184.216.119/32 dev eth0'];
#   }
#
# === Authors
#
# Raffael Schmid <raffael@yux.ch>
# Marius Rieder <marius.rieder@nine.ch>
# Sage Imel <sage@cat.pdx.edu>
# Nick Groenen <n.groenen@am-impact.nl>
#
# === Copyright
#
# Copyright 2012 Raffael Schmid <raffael@yux.ch>
#
define keepalived::vrrp_instance(
  $kind,
  $interface,
  $virtual_router_id = 10,
  $priority = undef,
  $advert_int = 1,
  $password = false,
  $virtual_addresses,
  $notify_master = false,
  $notify_backup = false,
  $notify_fault = false,
  $notify_all = false,
  $smtp_alert = false,
  $track_script = false,
) {

  if($kind != "MASTER" and $kind != "BACKUP" and $kind != "EQUAL") {
      fail("${kind} is not allowed, only MASTER, BACKUP, or EQUAL")
  }

  if($priority == undef) {
    $priority_real = $kind ? {
      'MASTER' => 200,
      'BACKUP' => 100,
    }
  }
  else {
    $priority_real = $priority
  }

  concat::fragment {
    "keepalived.vrrp_instance_${name}":
      content => template("keepalived/vrrp_instance.erb"),
      target  => '/etc/keepalived/concat/top',
      order   => 03;
  }

}
