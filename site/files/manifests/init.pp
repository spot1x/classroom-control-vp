class files {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  file { [ '/etc/cron.allow', '/etc/cron.deny' ]:
    ensure => file,
  }
  file_line { 'allow root cron jobs':
    ensure  => present,
    path    => '/etc/cron.allow',
    line    => 'root',
    require => File['/etc/cron.allow'],
  }
  # Add a rule to cron.deny to deny jobs by default
  file_line { 'prevent root cron jobs':
    ensure  => present,
    path    => '/etc/cron.deny',
    line    => '*',
    require => File['/etc/cron.deny'],
  }
  # What concat resource is needed for this fragment to work?
  concat { '/etc/motd':
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  concat::fragment { 'motd header':
    target  => '/etc/motd',
    order   => '01',
    content => epp('files/motd_header.epp'),
  }

  # Add a few fragments to be appended to /etc/motd
  concat::fragment {'motd message sample':
    target  => '/etc/motd',
    order   => '05',
    content => "Just appended a message to the motd by use of concat::fragment\n",
  }
}
