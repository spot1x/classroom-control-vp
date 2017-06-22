class files {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  file { [ '/etc/cron.allow', '/etc/cron.deny' ]:
    ensure => file,
    mode   => '0600',
  }
  file_line { 'allow root cron jobs':
    ensure  => present,
    path    => '/etc/cron.allow',
    line    => 'root',
    require => File['/etc/cron.allow'],
  }
  # Add a rule to cron.deny to deny jobs by default
  file_line { 'deny cron jobs by default':
    ensure  => present,
    path    => '/etc/cron.deny',
    line    => '*',
    require => File['/etc/cron.deny'],
  }

  # What concat resource is needed for this fragment to work?
  concat { '/etc/motd': }
  
  concat::fragment { 'motd header':
    target  => '/etc/motd',
    order   => '10',
    content => epp('files/motd_header.epp'),
  }

  # Add a few fragments to be appended to /etc/motd
  concat::fragment { 'motd welcome':
    target  => '/etc/motd',
    order   => '20',
    content => "Hello, world.\n",
  }
  
  concat::fragment { 'motd footer':
    target  => '/etc/motd',
    order   => '30',
    content => "\n*** EOF ***\n",  
  }
}
