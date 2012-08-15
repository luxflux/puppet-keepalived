define keepalived::real_server(
  $port,
  $weight = 10,
  $check,
  $connect_timeout = 4,
  $helo_name = "loadbalancer.healthcheck.local"
) {

  concat::fragment {
    "keepalived.virtual_server.${name}.${port}.real_server.${name}":
      content => template("keepalived/real_server.header.erb"),
      target  => "/etc/keepalived/keepalived.conf.part.${name}:${port}",
      order   => 50;
  }

}
