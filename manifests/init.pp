# keepalived.pp
#
# $Id$

class keepalived(
  $email,
  $smtp_server = '127.0.0.1'
) {

  package {
    "keepalived":
      ensure => installed;
  }

  service {
    "keepalived":
      ensure     => running,
      require    => Package["keepalived"],
      hasrestart => true,
      status     => 'pgrep keepalived',
      subscribe  => File["/etc/keepalived/keepalived.conf"];
  }

  concat {
    '/etc/keepalived/keepalived.conf':
      warn    => true,
      require => Package['keepalived'];
  }

  concat::fragment {
    'keepalived.global_defs':
      content => template("keepalived/global_defs.erb"),
      order   => 01,
      target  => '/etc/keepalived/keepalived.conf';
  }

}
