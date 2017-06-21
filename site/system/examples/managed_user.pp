# Linux requires a hash for the password. This one is 'Puppet8Labs!'
# Generate your own with the command `openssl passwd -1` if you'd like.

system::managed_user { ['aaron', 'kaitlin', 'alison']:
  password => $password,
}
