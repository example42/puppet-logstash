# Class: logstash::user
#
# This class creates logstash user
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by logstash
#
class logstash::user inherits logstash {
  @user { $logstash::process_user :
    ensure     => $logstash::manage_file,
    comment    => "${logstash::process_user} user",
    password   => '!',
    managehome => false,
    home       => $logstash::logstash_dir,
    shell      => '/bin/bash',
    before     => [Group[$logstash::process_group], Class['logstash']] ,
  }
  @group { $logstash::process_group :
    ensure     => $logstash::manage_file,
  }

  User <| title == $logstash::process_user |>
  Group <| title == $logstash::process_group |>

}
