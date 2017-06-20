class system::hosts {
resources {'host':
purge => true,
}
host { 'master.puppetlabs.vm':
ensure => present,
host_aliases => ['master'],
ip => '172.17.0.1', ## use the classroom IP
}
host { 'localhost':
ensure => present,
host_aliases => [
'localhost.localdomain',
'localhost4',
'localhost4.localdomain4',
'training.puppetlabs.vm',
'training'
],
ip => '127.0.0.1',
}
## Use your own IP, or the ::ipaddress fact
host { 'spot1x.puppetlabs.vm':
ensure => present,
host_aliases => ['spot1x'],
ip => '172.17.0.14',
}
}
