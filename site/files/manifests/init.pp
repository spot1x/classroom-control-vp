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
    ensure => present,
    path   => '/etc/cron.allow',
    line   => 'root',
  }

  # Add a rule to cron.deny to deny jobs by default
  file_line { 'prevent cron jobs':
    ensure => present,
    path   => '/etc/cron.deny',
    line   => '*'
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
  concat::fragment { 'motd joke':
    target  => '/etc/motd',
    order   => '10',
    content => 'Hello World! This was done by Puppet concat::fragment',
  }

}
