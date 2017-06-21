class system::admins {
  require mysql::server
  $retired = ['ralph']
  $active = ['brad', 'monica', 'luke', 'zack' ]
  
  $retired.each | $user | {
    mysql_user {"$user}@localhost":
      ensure => absent,
      }
      
   $active.each | $user | {
    mysql_user {"$user}@localhost":
      ensure => present,
      }
 #  $max_queries_600 = [ 'brad', 'monica', 'luke' ]
 #  $max_queries_1200 = [ "zack' ]
   
   
      
  
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

  user { ['zack', 'monica', 'ralph', 'brad', 'luke']:
    ensure => present,
  }
}
