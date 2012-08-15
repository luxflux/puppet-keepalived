define keepalived::virtual_server(
  $delay_loop = 10,
  $lb_algo = 'wrr',
  $lb_kind,
  $port,
  $protocol
) {

  concat {
    "/etc/keepalived/keepalived.conf.part.${name}:${port}":
      warn => true;
  }

  concat::fragment {
    "keepalived.virtual_server.${name}.${port}.header":
      content => template("keepalived/virtual_server.header.erb"),
      target  => "/etc/keepalived/keepalived.conf.part.${name}:${port}",
      order   => 01;

    "keepalived.virtual_server.${name}.${port}.footer":
      content => template("keepalived/virtual_server.footer.erb"),
      target  => "/etc/keepalived/keepalived.conf.part.${name}:${port}",
      order   => 99;
  }

}
