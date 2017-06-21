define system::managed_user (
  $password,
) {
  $homedir = $title ? {
  'root' => '/root',
  default => "/home/$user",
}

# Puppet will evaluate these resources in the proper order because it's smart
# and knows about dependencies between files and their owners
user { $title:
  ensure => present,
  password => $password,
  managehome => true,
}
if $kernel == 'Linux' {
 file { "${homedir}/.bashrc":
  ensure => file,
  owner => $title,
  group => $title,
  mode => '0644',
  source => 'puppet:///modules/system/bashrc'
  }
 }
}
