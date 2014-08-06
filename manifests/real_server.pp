# == Define: keepalived::real_server
#
# Add a vrrp_instance to the keepalived configuration.
#
# === Parameters
#
# [*name*]
#   Name of the vrrp instance.
#
# [*virtual_server_name*]
#   Specify keepalived::vrrp_instance name this real server belongs to.
#
# [*virtual_server_ip*]
#   Specify keepalived::vrrp_instance ip this real server belongs to.
#
# [*virtual_server_port*]
#   Specify keepalived::vrrp_instance ip this real server belongs to.
#
# [*ip*]
#   Specify the ip of the real server.
#
# [*port*]
#   Specify the port of the real server.
#
# [*weight*]
#   Specify the real server weight for load balancing decisions. (Default to: 10)
#
# [*check_type*]
#   Specify the check type (HTTP,SSL,SMTP,TCP)
#
# [*inhibit_on_failure*]
#   Set weight to 0 on healtchecker failure. (Default to: false)
#
# [*delay_before_retry*]
#   Delay between two successive retries. (Default to: 3)
#
# [*nb_get_retry*]
#   Maximum number of retries. (Default to: 3)
#
# [*connect_timeout*]
#   Connect remote server using timeout. (Default to: 3)
#
# [*bindto*]
#   Specify source ip for real server checks.
#
# [*url_path*]
#   Specify the url path. (Default to: /)
#
# [*url_digest*]
#   Specify the digest for a specific url path.
#
# [*url_status_code*]
#   Specify the status code for a specific url path. (Default to: 200)
#
# [*connect_port*]
#   Specify the port for TCP real server check.
#
# [*helo_name*]
#   Specify the HELP server name for SMTP real server check. (Default to: loadbalancer.healthcheck.local)
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
# Tobias Brunner <tobis.brunner@nine.ch>
# Marius Rieder <marius.rieder@nine.ch>
#
# === Copyright
#
# Copyright 2012 Raffael Schmid <raffael@yux.ch>
#
define keepalived::real_server(
  $virtual_server_name,
  $virtual_server_ip,
  $virtual_server_port,
  $ip,
  $port,
  $weight = 10,
  $check_type,
  $inhibit_on_failure = false,

  $delay_before_retry = 3,
  $nb_get_retry = 3,
  $connect_timeout = 3,
  $bindto = false,

  $url_path = '/',
  $url_digest = false,
  $url_status_code = '200',

  $connect_port = false,

  $helo_name = "loadbalancer.healthcheck.local"
) {

  validate_bool($inhibit_on_failure)
  validate_re($check_type, ['HTTP', 'SSL', 'TCP', 'SMTP'])

  concat::fragment {
    "keepalived.virtual_server.${virtual_server_ip}.${virtual_server_port}.real_server.${ip}":
      content => template("keepalived/real_server.erb"),
      target  => "/etc/keepalived/concat/virtual_server.${virtual_server_ip}:${virtual_server_port}",
      order   => 50;
  }

}
