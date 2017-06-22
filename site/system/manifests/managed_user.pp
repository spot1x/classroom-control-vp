define system::managed_user (
  $password,
  $home = undef,
) {
  if $home {
    $homedir = $home
  }
  else {
    $homedir = homedir($name)
  }

  File {
    owner => $name,
    group => 'wheel',
    mode  => '0644',
  }

  # manage a user called $name and that user's `.bashrc` if they're on Linux
  # This can likely reuse some of the code you wrote for the `review` class.
  # Make sure you update variables or paths as required.

  user { $name :
    ensure     => present,
    home       => $homedir,
    password   => $password,
    managehome => true,
  }

  if($::kernel == 'Linux') {
    file { "${homedir}/.bashrc":
      ensure => file,
      source => 'puppet:///modules/system/bashrc'
    }
  }
}
