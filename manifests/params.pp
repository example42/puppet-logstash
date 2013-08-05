# Class: logstash::params
#
# This class defines default parameters used by the main module class logstash
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to logstash class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class logstash::params {
  # ## Module specific parameters
  $run_mode = 'agent'
  $run_options = ''
  $install_prerequisites = true
  $create_user = true
  $version = '1.1.13'
  $jartype = 'flatjar'
  $install = 'source'
  $install_destination = '/opt'
  $install_precommand = ''
  $install_postcommand = ''

  $init_script_template = $::osfamily ? {
    'Debian' => 'logstash/logstash.init.erb',
    # 'Debian' => 'logstash/logstash.init-debian.erb',
    default  => 'logstash/logstash.init.erb',
  }

  $upstart_template = 'logstash/logstash.upstart.erb'
  $base_install_source = 'http://logstash.objects.dreamhost.com/release'
  $source_dir_patterns = ''
  $use_upstart = false
  $maxopenfiles = ''

  # ## Application related parameters

  $package = $::operatingsystem ? {
    default => 'logstash',
  }

  $service = $::operatingsystem ? {
    default => 'logstash',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'java',
  }

  $process_args = $::operatingsystem ? {
    default => 'logstash',
  }

  $process_user = $::operatingsystem ? {
    default => 'logstash',
  }

  $process_group = $::operatingsystem ? {
    default => 'logstash',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/logstash/logstash.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/logstash.pid',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/logstash',
  }

  $data_dir = ''
  $base_data_dir = $::operatingsystem ? {
    default => '/var/lib/logstash',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/logstash',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/logstash/logstash.log',
  }

  $port = '9292'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $absent = false
  $disable = false
  $disableboot = false

  # ## General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $puppi = false
  $puppi_helper = 'java'
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/24'
  $firewall_dst = $::ipaddress
  $debug = false
  $audit_only = false

}
