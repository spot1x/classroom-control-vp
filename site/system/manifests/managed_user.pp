define system::managed_user (
  $password,
  $home = undef,
) {
  if $home {
    $homedir = $home
  }
  else {
    $homedir = "/home/${name}"
  }

  File {
    owner => $name,
    group => 'wheel',
    mode  => '0644',
  }

  # manage a user called $name and that user's `.bashrc` if they're on Linux
  # This can likely reuse some of the code you wrote for the `review` class.
  # Make sure you update variables or paths as required.
  user { $name:
    password   => $password,
    ensure     => present,
    managehome => true,
    home       => $homedir,
  }
  
  if $kernel == 'Linux' {
    file { "${homedir}/bashrc":
      ensure => present,
      source => 'puppet:///modules/system/bashrc',
      #cowsay => "Welcome ${name} to the ${kernel} box",
  }
}
