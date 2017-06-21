class system::admins {
  require mysql::server

  $active_users = {
    'zack'   => {max_queries_per_hour            => 1200},
    'ralph'                           => {active =>  false},
    'monica'                                     => {},
    'brad'                                       => {},
    'luke'                                       => {},
  }

  $active_users.each |String $username, Hash $attr| {
    user { $name:
      ensure => present
    }

    if defined($attr['max_queries_per_hour']) {
      $max_queries_per_hour = $attr['max_queries_per_hour']
    } else {
      $max_queries_per_hour = 600
    }

    if defined($attr['active']) and $attr['active'] {
      $is_active = absent
    } else {
      $is_active = present
    }

    mysql_user { "${name}@localhost":
      ensure               => $is_active,
      max_queries_per_hour => $max_queries_per_hour
    }
  }
}
