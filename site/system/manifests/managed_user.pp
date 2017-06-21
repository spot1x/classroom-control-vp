define system::managed_user (
  $home = undef,
  $password,
) {
  if $home {
    $homedir = $home
  }
  else {
    $homedir = "/home/${name}"
  }
  
  user { $title:
    ensure     => present,
    password   => $password,
    managehome => true,
  }
  
  File {
    owner => $name,
    group => 'wheel',
    mode  => '0644',
  }

  # manage a user called $name and that user's `.bashrc` if they're on Linux
  # This can likely reuse some of the code you wrote for the `review` class.
  # Make sure you update variables or paths as required.
}
