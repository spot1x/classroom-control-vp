  # this class should accept a parameter rather than having
  # the username hardcoded.
 class review (
   $user = 'review')
 {
 
  # Uncomment and use this variable where appropriate
  $homedir = $user ? {
    'root'  => '/root',
    default => "/home/$user",
  }

  user { $user:
    ensure     => present,
    shell      => '/bin/bash',
    home       => $homedir
    managehome => true,
  }

  file { "${homedir}/.bashrc":
    ensure => file,
    owner  => $user,
    group  => $user,
    mode   => '0644',
    source => 'puppet:///modules/review/bashrc'
  }

  # add the proper resource to ensure that the Puppet agent is not running
  # in the background. How would you discover the service name?
  service { 'puppet':
    ensure => stopped
    enable => false
}
