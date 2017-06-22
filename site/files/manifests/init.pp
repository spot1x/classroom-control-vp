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

  $fqdn = ${facts['fqdn']}
  $osname = ${facts['os']['name']}
  $osrelease = ${facts['release']['full']}
  $message = "You are logged in to ${fqdn} running ${osname} ${osrelease}."
#  $message = "You are logged in to ${facts['fqdn']} running ${facts['os']['name']} ${facts['release']['full']}."
  concat::fragment { 'motd os info':
    target  => '/etc/motd',
    order   => '20',
    content => $message,
    require => File['/etc/motd'],
  }

  concat::fragment { 'motd footer':
    target  => '/etc/motd',
    order   => '100',
    content => 'So long and thanks for all the fish! :)',
    require => File['/etc/motd'],
  }
}
