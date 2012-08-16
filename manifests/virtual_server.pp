define keepalived::virtual_server(
  $delay_loop = 10,
  $lb_algo = 'wrr',
  $lb_kind,
  $port,
  $protocol
) {

  concat {
    "/etc/keepalived/concat/virtual_server.${name}:${port}":
      notify  => Exec['concat_keepalived.conf'];
  }

  concat::fragment {
    "keepalived.virtual_server.${name}.${port}.header":
      content => template("keepalived/virtual_server.header.erb"),
      target  => "/etc/keepalived/concat/virtual_server.${name}:${port}",
      order   => 01;

    "keepalived.virtual_server.${name}.${port}.footer":
      content => template("keepalived/virtual_server.footer.erb"),
      target  => "/etc/keepalived/concat/virtual_server.${name}:${port}",
      order   => 99;
  }

  Keepalived::Real_server <<| |>>

}
