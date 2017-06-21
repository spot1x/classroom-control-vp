class system::admins {
  require mysql::server

  $active_users = {
    'zack'   => {max_queries_per_hour            => 1200},
    'ralph'                           => {active => absent},
    'monica'                                     => {},
    'brad'                                       => {},
    'luke'                                       => {},
  }

  $active_users.each |String $username, Hash $attr| {
    user { $username:
      ensure => present
    }

    if $attr['max_queries_per_hour'] {
      $max_queries_per_hour = $attr['max_queries_per_hour']
    } else {
      $max_queries_per_hour = 600
    }

    if $attr['active'] {
      $is_active = $attr['active']
    } else {
      $is_active = present
    }

    mysql_user { "${username}@localhost":
      ensure               => $is_active,
      max_queries_per_hour => $max_queries_per_hour
    }
  }
}
