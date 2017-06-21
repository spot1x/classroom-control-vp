define system::managed_user (
  $home = undef,
) {
  if $home {
    $homedir = $home
  }
  else {
    $homedir = "/home/${name}"
  }
  $password = '$1$Kqjc./GG$fvVBzF2sctwBblFesdR3q0'
system::managed_user { ['aaron','kaitlin','alison']:
password => $password,
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
