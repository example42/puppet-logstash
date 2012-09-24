# = Define: logstash::config
#
# This define creates a configuration file for logstash
#
# == Parameters
#
# [*source*]
#   Sets the content of source parameter for configuration file
#   If defined, this config file will have the param:
#   source => $source
#
# [*template*]
#   Sets the path to the template to use as content for configuration file
#   If defined, logstash this config file will have the param:
#   content => content("$template")
#   NOTE: source and template parameters are mutually exclusive: don't use both
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#
# [*ensure*]
#   Defines the status of the file. Default: present
#   Set to 'absent' if you want to remove an existing config
#
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
