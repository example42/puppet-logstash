# Class: logstash::service
#
# This class manages logstash services
#
# == Variables
#
# Refer to logstash class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by logstash
#
class logstash::service inherits logstash {

  case $logstash::install {

    package: {
      service { 'logstash':
        ensure     => $logstash::manage_service_ensure,
        name       => $logstash::service,
        enable     => $logstash::manage_service_enable,
        hasstatus  => $logstash::service_status,
        pattern    => $logstash::process,
        require    => Package['logstash'],
      }
    }

    source,puppi: {
      service { 'logstash':
        ensure     => $logstash::manage_service_ensure,
        name       => $logstash::service,
        enable     => $logstash::manage_service_enable,
        hasstatus  => $logstash::service_status,
        pattern    => $logstash::process,
      }

    if $logstash::bool_use_upstart == true {
      file { 'logstash.upstart':
        ensure  => $logstash::manage_file,
        path    => '/etc/init/logstash.conf',
        mode    => '0644',
        owner   => $logstash::config_file_owner,
        group   => $logstash::config_file_group,
        require => Class['logstash::install'],
        before  => Service['logstash'],
        content => template($logstash::upstart_template),
        audit   => $logstash::manage_audit,
      }
    } else {
      file { 'logstash.init':
        ensure  => $logstash::manage_file,
        path    => '/etc/init.d/logstash',
        mode    => '0755',
        owner   => $logstash::config_file_owner,
        group   => $logstash::config_file_group,
        require => Class['logstash::install'],
        before  => Service['logstash'],
        content => template($logstash::init_script_template),
        audit   => $logstash::manage_audit,
      }
    }

    }

    default: { }

  }


  ### Service monitoring, if enabled ( monitor => true )
  if $logstash::bool_monitor == true {
    if $logstash::run_mode == 'web' {
      monitor::port { "logstash_${logstash::protocol}_${logstash::port}":
        protocol => $logstash::protocol,
        port     => $logstash::port,
        target   => $logstash::monitor_target,
        tool     => $logstash::monitor_tool,
        enable   => $logstash::manage_monitor,
      }
    }
    monitor::process { 'logstash_process':
      process  => $logstash::process,
      service  => $logstash::service,
      pidfile  => $logstash::pid_file,
      user     => $logstash::process_user,
      argument => $logstash::process_args,
      tool     => $logstash::monitor_tool,
      enable   => $logstash::manage_monitor,
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $logstash::bool_firewall == true {
    firewall { "logstash_${logstash::protocol}_${logstash::port}":
      source      => $logstash::firewall_src,
      destination => $logstash::firewall_dst,
      protocol    => $logstash::protocol,
      port        => $logstash::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $logstash::firewall_tool,
      enable      => $logstash::manage_firewall,
    }
  }

}
