class review::motd {
  file { '/etc/motd.pp':
    ensure   => file,
    user     => 'root',
    group    => 'root',
    mode     => '0644',
    contennt => epp('review/motd.pp), 
  }
}
