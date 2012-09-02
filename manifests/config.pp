define logstash::config (
  $source   = '',
  $template = '',
  $options  = '',
  $ensure   = 'present'
  ) {

  $manage_file_source = $source ? {
    ''        => undef,
    default   => $source,
  }

  $manage_file_content = $template ? {
    ''        => undef,
    default   => template($template),
  }

  require logstash

  file { "logstash.conf_${name}":
    ensure  => $ensure,
    path    => "${logstash::config_dir}/${name}.conf",
    mode    => $logstash::config_file_mode,
    owner   => $logstash::config_file_owner,
    group   => $logstash::config_file_group,
    require => Class['logstash::install'],
    notify  => $logstash::manage_service_autorestart,
    source  => $manage_file_source,
    content => $manage_file_content,
    replace => $logstash::manage_file_replace,
    audit   => $logstash::manage_audit,
  }
}
