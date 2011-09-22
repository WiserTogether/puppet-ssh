class ssh {
    package { "openssh-server":
        ensure  => installed
    }

    file { "sshdconfig":
        name    => "/etc/ssh/sshd_config",
        content => template("ssh/sshd_config.erb"),
        owner   => "root",
    }

    service { "sshd":
        require => Package[openssh-server],
        subscribe => File[sshdconfig],
        enable  => true,
        ensure  => running,
        hasrestart => true,
        hasstatus => true,
        restart => "/etc/init.d/sshd restart",
        status => "/etc/init.d/sshd status"
    }
}
