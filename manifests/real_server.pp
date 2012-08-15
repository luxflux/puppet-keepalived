define keepalived::real_server(
  $port,
  $weight = 10,
  $check_type,
  $connect_timeout = 4,
  $helo_name = "loadbalancer.healthcheck.local"
) {

  concat::fragment {
    "keepalived.virtual_server.${name}.${port}.real_server.${name}":
      content => template("keepalived/real_server.erb"),
      target  => "/etc/keepalived/keepalived.conf.part.${name}:${port}",
      order   => 50;
  }

}
