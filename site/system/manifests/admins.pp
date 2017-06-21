class system::admins {
  require mysql::server

  #Retired users
  $inactive_users = [ 'ralph' ]

  $default_max_queries_per_hour = 600

  #Active users
  $active_users = {
    'brad' => {
      },
    'monica' => {
      },
    'luke' => {
      },
    'zack' => {
      'max_queries_per_hour' => 1200
    },
  }

  $active_users.each |String $userName, Hash $data| {
    if defined($data['max_queries_per_hour']) {
      $actual_max_queries_per_hour = $data['max_queries_per_hour']
    } else {
      $actual_max_queries_per_hour = $default_max_queries_per_hour
    }

    mysql_user { "${userName}@localhost":
      ensure => present,
      max_queries_per_hour => $actual_max_queries_per_hour,
    }
    user { $userName:
      ensure => present,
      }
    }

  $inactive_users.each |$userName| {
    mysql_user { "${userName}@localhost":
    ensure => absent,
    }
    user { $userName:
    ensure => absent,
    }
  }
}
