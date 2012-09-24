# Class: logstash::prerequisites
#
# This class installs logstash prerequisites
#
# == Variables
#
# Refer to logstash class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by logstash if the parameter
# install_prerequisites is set to true
# Note: This class may contain resources available on the
# Example42 modules set
#
class logstash::prerequisites {

  include java

  case $::operatingsystem {
    redhat,centos,scientific: {
      if $logstash::install == 'package' {
        require yum::repo::monitoringsucks
      }
    }
    default: { }
  }
}
