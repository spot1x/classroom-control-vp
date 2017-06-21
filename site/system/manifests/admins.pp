class system::admins {
  require mysql::server
  
  $retired = ['ralph']
  
  $admins = {
    'zack' => {max_queries_per_hour => '1200'},
    'monica'=> {max_queries_per_hour => '600'},
    'ralph'=> {max_queries_per_hour => '600'},
    'brad'=> {max_queries_per_hour => '600'},
    'luke'=> {max_queries_per_hour => '600'},
    }
    
  $admins.each | String $admin| {
    mysql_user { "${admin}@localhost":
      ensure               => present,
      max_queries_per_hour => $params['max_queries_per_hour'],
    }
  }
  
  $retired.each | String $retire| {
    mysql_user { "${retire}@localhost":
      ensure               => absent,
    }
  }
}
