define system::managed_user (
  $password,
) {
  $homedir = $name ? {
    'root' => '/root',
    default => "/home/${name}",
  }
  
  user { $name:
    ensure => present,
    password => $password,
    managehome => true,
  }
  
  if $kernel == 'Linux' {
    file { "${homedir}/.bashrc":
      ensure => file,
      owner => $name,
      group => $name,
      mode => '0644',
      source => 'puppet:///modules/system/bashrc',
    }
  }
  # manage a user called $name and that user's `.bashrc` if they're on Linux
  # This can likely reuse some of the code you wrote for the `review` class.
  # Make sure you update variables or paths as required.
}
