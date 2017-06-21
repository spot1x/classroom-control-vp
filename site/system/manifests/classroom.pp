class system::classroom {
  # export a virtual host resource for yourself
  #@@host { $::fqdn:
  #  ensure => present,
  #  ip => $::ipaddress,
  #  tag => 'classroom',
  #}

  # collect all resources from the database (including your own)
  # enforce only those tagged with `classroom`.


}
