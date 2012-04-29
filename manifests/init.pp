class sshd {
    package { "openssh-server":
        ensure  => installed
    }

    file { "sshdconfig":
        name    => "/etc/ssh/sshd_config",
        content => template("sshd/sshd_config.erb"),
        owner   => "root",
    }

    file { "/etc/banner":
        source  => "puppet:///modules/sshd/banner",
        owner   => "root",
    }

    service { "sshd":
        require => Package[openssh-server],
        subscribe => [File[sshdconfig], File["/etc/banner"]],
        enable  => true,
        ensure  => running,
        hasrestart => true,
        hasstatus => true,
        restart => "/etc/init.d/sshd restart",
        status => "/etc/init.d/sshd status"
    }
}
