define keepalived::real_server(
  $virtual_server_name,
  $virtual_server_port,
  $port,
  $weight = 10,
  $check_type,
  $connect_timeout = 4,
  $inhibit_on_failure = false,

  $delay_before_retry = false,
  $connect_timeout = false,
  $bindto = false,

  $url_path = false,
  $url_digest = false,
  $url_status_code = false,

  $connect_port = false,

  $helo_name = "loadbalancer.healthcheck.local"
) {

  validate_bool($inhibit_on_failure)
  validate_re($check_type, ['HTTP', 'SSL', 'TCP', 'SMTP'])

  concat::fragment {
    "keepalived.virtual_server.${virtual_server_name}.${virtual_server_port}.real_server.${name}":
      content => template("keepalived/real_server.erb"),
      target  => "/etc/keepalived/concat/virtual_server.${virtual_server_name}:${virtual_server_port}",
      order   => 50;
  }

}
