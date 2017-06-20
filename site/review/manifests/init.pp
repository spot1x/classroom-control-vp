class review ($user = 'review',) {
  # this class should accept a parameter rather than having the username hardcoded.

  include review::motd
  
  user { $user:
    ensure     => present,
    shell      => '/bin/bash',
    managehome => true,
  }
 
  $homedir = $user ? {
    'root'  => '/root',
    default => "/home/${user}",
  }

  file { "${homedir}/.bashrc":
    ensure => file,
    owner  => $user,
    group  => $user,
    mode   => '0644',
    source => 'puppet:///modules/review/bashrc'
  }
  
  service { 'puppet':
    ensure  => stopped,
    enabled => false,
  }

}
