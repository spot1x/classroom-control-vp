class review::motd {
  file { '/etc/motd':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
    content => epp('review/motd.pp'),
  }
}
