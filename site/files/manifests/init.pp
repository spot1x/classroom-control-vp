class files {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  file { '/etc/cron.allow':
    ensure => file,
  }
  file_line { 'allow root cron jobs':
    ensure => present,
    path   => '/etc/cron.allow',
    line   => 'root',
    require => File['/etc/cron.allow'],
  }
  # Add a rule to cron.deny to deny jobs by default
  file { '/etc/cron.deny':
    ensure => file,
  }
  file_line { 'deny cron jobs by default':
    ensure => present,
    path   => '/etc/cron.deny',
    line   => '*',
    require => File['/etc/cron.deny'],
  }

  file { '/etc/motd':
    ensure => file,
  }

  # What concat resource is needed for this fragment to work?
  concat { '/etc/motd':
  }
  
  concat::fragment { 'motd header':
    target  => '/etc/motd',
    order   => '01',
    content => epp('files/motd_header.epp'),
    require => File['/etc/motd'],
  }

  # Add a few fragments to be appended to /etc/motd

  concat::fragment { 'motd os info':
    target  => '/etc/motd',
    order   => '20',
    content => "You are logged in to ${facts['fqdn']} running ${facts['os']['name']} ${facts['os']['release']['full']}.\n\n",
    require => File['/etc/motd'],
  }

  concat::fragment { 'motd footer':
    target  => '/etc/motd',
    order   => '90',
    content => "\nSo long and thanks for all the fish! :)\n",
    require => File['/etc/motd'],
  }
}
