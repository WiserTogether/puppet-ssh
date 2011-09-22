class ssh {
    package { "openssh-server":
        ensure  => installed
    }

    file { "sshdconfig":
        name    => "/etc/ssh/sshd_config",
        content => template("ssh/sshd_config.erb"),
        owner   => "root",
    }

    service { "ssh":
        require => Package[openssh-server],
        subscribe => File[sshdconfig],
        enable  => true,
        ensure  => running,
    }
}
