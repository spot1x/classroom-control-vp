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
  }
  # Add a rule to cron.deny to deny jobs by default
  
  file { '/etc/cron.deny':
    ensure => file,
  }
  file_line { 'deny root cron jobs':
    ensure => present,
    path   => '/etc/cron.deny',
    line   => '*',
  }

  # What concat resource is needed for this fragment to work?
  concat::fragment { 'motd header':
    target  => '/etc/motd',
    order   => '01',
    content => epp('files/motd_header.epp'),
  }

  # Add a few fragments to be appended to /etc/motd
  concat::fragment { 'sample motd message':
    target  => '/etc/motd',
    order   => '50',
    content => "This is a sample motd message\n",
  }  
}
