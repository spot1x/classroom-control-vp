class ordering {
  include ordering::mysql
   notify { 'This should come after the entire MySQL class is enforced':
   require => Class['ordering::mysql'],
 }
}
