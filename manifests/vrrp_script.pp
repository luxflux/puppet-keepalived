# == Define: keepalived::vrrp_script
#
# Add a vrrp_script definition to the keepalived configuration.
#
# === Parameters
#
# [*name*]
#   Name of the script as used in vrrp_instance.
#
# [*script*]
#   Specify a shell script to be executed.
#
# [*interval*]
#   Specify in seconds the interval between check.
#
# [*rise*]
#   Specify the number of successes to rise the state to OK.
#
# [*fall*]
#   Specify the number of failures to degrade the state to KO.
#
# === Examples
#
#   keepalived::vrrp_script { 'example_tracker':
#     script   => '/usr/local/bin/mycheckscript.sh',
#     interval => 5,
#     fall     => 2,
#     rise     => 2;
#   }
#
#   keepalived::virtual_server {  'example.com':
#     ip                  => '93.184.216.119',
#     port                => 80,
#     lb_kind             => 'NAT',
#     lb_algo             => 'wrr',
#     protocol            => 'TCP',
#     delay_loop          => '5',
#     sorry_server        => '93.184.216.118 80',
#     persistence_timeout => 0,
#     track_script        => 'example_tracker';
#   }
#
# === Authors
#
# Tobias Brunner <tobias.brunner@nine.ch>
# Marius Rieder <marius.rieder@nine.ch>
#
# === Copyright
#
# Copyright 2012 Raffael Schmid <raffael@yux.ch>
#
define keepalived::vrrp_script(
  $script,
  $interval,
  $rise = false,
  $fall = false,
) {

  concat::fragment {
    "keepalived.vrrp_script_${name}":
      content => template("keepalived/vrrp_script.erb"),
      target  => '/etc/keepalived/concat/top',
      order   => 01;
  }

}
