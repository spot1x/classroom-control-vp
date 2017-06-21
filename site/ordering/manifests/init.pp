class ordering {
  # include the ordering::mysql class
  # Does it need to be contained?
  include mysql::ordering

  notify { 'This should come after the entire MySQL class is enforced':
    require => Class['ordering::mysql'],
  }
}
