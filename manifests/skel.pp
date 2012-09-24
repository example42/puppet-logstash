# Class: logstash::skel
#
# This class creates additional logstash resources
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by logstash
#
class logstash::skel inherits logstash {

  file { 'logstash.log_dir':
    ensure  => directory,
    path    => $logstash::log_dir,
    require => Class['logstash::install'],
    owner   => $logstash::process_user,
    group   => $logstash::process_group,
    audit   => $logstash::manage_audit,
  }

  file { 'logstash.data_dir':
    ensure  => directory,
    path    => $logstash::real_data_dir,
    require => Class['logstash::install'],
    owner   => $logstash::process_user,
    group   => $logstash::process_group,
    audit   => $logstash::manage_audit,
  }

  if $logstash::source_dir_patterns {
    file { 'logstash.dir_patterns':
      ensure  => directory,
      path    => "${logstash::logstash_dir}/patterns",
      require => File['logstash.data_dir'],
      owner   => $logstash::process_user,
      group   => $logstash::process_group,
      audit   => $logstash::manage_audit,
      recurse => true,
      source  => $logstash::source_dir_patterns,
    }
  }
}
