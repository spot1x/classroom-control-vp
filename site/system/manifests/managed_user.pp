$password = '1$Ym8Uo14S$Qt717jqos1tgZaZdFyLCW1'

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

  File {
    owner => $name,
    group => 'wheel',
    mode  => '0644',
  }

  # manage a user called $name and that user's `.bashrc` if they're on Linux
  # This can likely reuse some of the code you wrote for the `review` class.
  # Make sure you update variables or paths as required.
  user { $name:
    ensure      => present,
    managehome  => true,
    home        => $homedir,
    password    => $password,
   }
   
  if $kernel == 'Linux' {
   file { "${homedir}/.bashrc":
     ensure  => $file,
     source  =>  'puppet://modules/system/bashrc'.
   }
 }
