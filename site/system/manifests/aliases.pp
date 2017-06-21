class system::aliases (
    Pattern [/\A[a-z].*/, /^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/] $admin = 'root',
) {
    # uses $admin to build the aliases file
    file { '/etc/aliases':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => epp('system/aliases.epp', { admin => $admin }),
    }
    exec { '/usr/bin/newaliases':
        refreshonly => true,
        subscribe   => File['/etc/aliases'],
    }
}
