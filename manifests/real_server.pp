define keepalived::real_server(
  $virtual_server_name,
  $virtual_server_port,
  $port,
  $weight = 10,
  $check_type,
  $connect_timeout = 4,
  $helo_name = "loadbalancer.healthcheck.local"
) {

  concat::fragment {
    "keepalived.virtual_server.${virtual_server_name}.${virtual_server_port}.real_server.${name}":
      content => template("keepalived/real_server.erb"),
      target  => "/etc/keepalived/keepalived.conf.part.${virtual_server_name}:${virtual_server_port}",
      order   => 50;
  }

}
