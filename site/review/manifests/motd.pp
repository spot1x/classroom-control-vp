class review::motd {

  file { '/etc/motd':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0064',
    content => epp('review/motd.epp'),
  }
}
