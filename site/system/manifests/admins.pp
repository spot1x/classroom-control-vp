class system::admins {
  require mysql::server

  {
    'zack' => {
      max_queries_per_hour => 1200,
      active => true,
    },
    'monica' => {
      max_queries_per_hour => 600,
      active => true,
    },
    'ralph' => {
      max_queries_per_hour => undef,
      active => false,
    },
    'brad' => {
      max_queries_per_hour => 600,
      active => true,
    },
    'luke' => {
      max_queries_per_hour => 600,
      active => true,
    },
  }.each | String $username, Hash $attributes | {
    if $attributes['active'] {
      mysql_user { "${username}@localhost":
        ensure => present,
        max_queries_per_hour => $attributes['max_queries_per_hour'],
      }
      user { $username:
        ensure => present,
        managehome => true,
      }
    }
    else {
      mysql_user { "${username}@localhost":
        ensure => absent,
      }
      user { $username:
        ensure => absent,
      }
    }
  }
}
