# == Class: keepalived
#
# Manage the keepalived configuration and service.
#
# === Parameters
#
# [*email*]
#   Specify email accounts that will receive the notification email.
#
# [*smtp_server*]
#   Specify the outgoing email server. (Default to: 127.0.0.1)
#
# [*enable*]
#   Specify if the keepalived service should be enabled. (Default to: true)
#
# === Examples
#
#  class { 'keepalived':
#    email => 'root@example.com',
#  }
#
# === Authors
#
# Raffael Schmid <raffael@yux.ch>
# Sage Imel <sage@cat.pdx.edu>
# Marius Rieder <marius.rieder@nine.ch>
#
# === Copyright
#
# Copyright 2012 Raffael Schmid <raffael@yux.ch>
#
class keepalived(
  $email,
  $smtp_server = '127.0.0.1',
  $enable = true
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
      enable     => $enable,
      status     => 'pgrep keepalived',
      subscribe  => File["/etc/keepalived/concat/top"];
  }

  file {
    '/etc/keepalived/concat':
      ensure  => directory,
      purge   => true,
      recurse => true,
      require => Package['keepalived'],
      notify  => Exec['concat_keepalived.conf'];

  }

  file {
    '/etc/keepalived/keepalived.conf':
      ensure  => present,
      source  => '/etc/keepalived/concat.out',
      require => Exec['concat_keepalived.conf'];

    '/etc/keepalived/concat.out':
      notify => Exec['concat_keepalived.conf'];
  }

  exec {
    'concat_keepalived.conf':
      command     => '/bin/cat /etc/keepalived/concat/* > /etc/keepalived/concat.out',
      refreshonly => true,
      notify      => Service['keepalived'];
  }

  concat {
    '/etc/keepalived/concat/top':
      warn    => true,
      require => Package['keepalived'],
      notify  => Exec['concat_keepalived.conf'];
  }

  concat::fragment {
    'keepalived.global_defs':
      content => template("keepalived/global_defs.erb"),
      order   => 01,
      target  => '/etc/keepalived/concat/top';
  }

}
