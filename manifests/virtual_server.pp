define keepalived::virtual_server(
  $sorry_server = false,
  $persistence_timeout = '60',
  $delay_loop = 10,
  $lb_algo = 'wrr',
  $lb_kind,
  $port,
  $protocol,
  $ip,
  $bindto = false
) {

  concat {
    "/etc/keepalived/concat/virtual_server.${ip}:${port}":
      notify  => Exec['concat_keepalived.conf'];
  }

  concat::fragment {
    "keepalived.virtual_server.${ip}.${port}.header":
      content => template("keepalived/virtual_server.header.erb"),
      target  => "/etc/keepalived/concat/virtual_server.${ip}:${port}",
      order   => 01;

    "keepalived.virtual_server.${ip}.${port}.footer":
      content => template("keepalived/virtual_server.footer.erb"),
      target  => "/etc/keepalived/concat/virtual_server.${ip}:${port}",
      order   => 99;
  }

  if $bindto {
    Keepalived::Real_server <<| virtual_server_name == $name |>> {
      bindto => $bindto
    }
  } else {
    Keepalived::Real_server <<| virtual_server_name == $name |>>
  }
}
