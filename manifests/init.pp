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

    common::concatfilepart {
        "global_defs":
            ensure  => present,
            manage  => true,
            content => template("keepalived/global_defs.erb"),
            file    => "${::system_etc_dir}/keepalived/keepalived.conf",
            require => Package["keepalived"];
    }

    service {
        "keepalived":
            ensure     => running,
            require    => Package["keepalived"],
            hasrestart => true,
            status     => 'pgrep keepalived',
            subscribe  => File["${::system_etc_dir}/keepalived/keepalived.conf"];
    }

}
