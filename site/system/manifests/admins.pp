class system::admins {
  require mysql::server
  
  $retired = ['ralph']
  $admins = {
  'brad' => { max_queries_per_hour => '600' }, 
  'monica' => { max_queries_per_hour => '600' }, 
  'luke' => { max_queries_per_hour => '600' }, 
  'zack' => { max_queries_per_hour => '1200' },
  }

$admins.each |$user, $params| { 
  mysql_user { "${user}@localhost":
  ensure => present,
  max_queries_per_hour => $params['max_queries_per_hour'], 
  }

  mysql_user { 'zack@localhost':
    ensure => present,
    max_queries_per_hour => 1200,
  }
  mysql_user { 'monica@localhost':
    ensure => present,
    max_queries_per_hour => 600,
  }
  mysql_user { 'ralph@localhost':
    ensure => absent,
  }
  mysql_user { 'brad@localhost':
    ensure => present,
    max_queries_per_hour => 600,
  }
  mysql_user { 'luke@localhost':
    ensure => present,
    max_queries_per_hour => 600,
  }

  user { $user:
  ensure => present, 
  managehome => true,
  }
}
