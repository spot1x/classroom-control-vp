class system::admins {
  require mysql::server
  $admins = [
    {
      username => "zack",
      max_queries_per_hour => 1200,
      active => true,
    },
    {
      username => "monica",
      max_queries_per_hour => 600,
      active => true,
    },
    {
      username => "ralph",
      max_queries_per_hour => undef,
      active => false,
    },
    {
      username => "brad",
      max_queries_per_hour => 600,
      active => true,
    },
    {
      username => "luke",
      max_queries_per_hour => 600,
      active => true,
    },
  ]

  $admins.each | String $username, Hash $attributes | {
    if $active {
      mysql_user { "${username}@localhost":
        ensure => present,
        max_queries_per_hour => $attributes[max_queries_per_hour],
      }
      user { "${username}":
        ensure => present,
      }
    }
    else {
      mysql_user { "${username}@localhost":
        ensure => absent,
      }
      user { "${username}":
        ensure => absent,
      }
    }
  }
}
