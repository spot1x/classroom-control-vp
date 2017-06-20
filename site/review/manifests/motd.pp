class review::motd {
  file { '/etc/motd':
    ensure  => file,
    user    => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('review/motd.epp'), 
  }
}
