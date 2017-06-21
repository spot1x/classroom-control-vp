class system::vhost_example {
  package { 'httpd':
    ensure => present,
  }

  file { '/etc/httpd/conf/httpd.conf':
    ensure => file,
    source => 'puppet:///modules/apache/httpd.conf',
  }
  
  $vhosts = hiera('customers::vhosts')
  
  $vhosts.each |String $vhost| {
     apache::vhost { $vhost:
       docroot => "/etc/httpd/conf/vhosts/${vhost}",
       require => Package['httpd'],
       notify  => Service['httpd'],
     }
  }
  
  service { 'httpd':
    ensure => running,
    enable => true,
  }

  Package['httpd'] -> File['/etc/httpd/conf/httpd.conf'] ~> Service['httpd']
}
