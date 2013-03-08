# Puppet module: logstash

This is a Puppet logstash module from the second generation of Example42 Puppet Modules.

Made by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-logstash

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module.

For detailed info about the logic and usage patterns of Example42 modules read README.usage on Example42 main modules set.

## USAGE - Module Specific Parameters

* Launch in agent mode (default) with extra parameters to enable the web interface
        class { "logstash":
          run_options => 'web --backend elasticsearch:///',
        }

* Create a configuration file based on the provided template. 
        logstash::config { 'local_search':
          template => '<module>/[path]/<template>',
        }


## USAGE - Basic management

* Install logstash using your distro package, if available

        class { "logstash": }

* Install the latest logstash version from upstream site

        class { "logstash":
          install             => "source",
        }

* Install the latest logstash version from upstream site using puppi. 
  You will have a 'puppi deploy logstash' to deploy and update logstash.

        class { "logstash":
          install             => "puppi",
        }

* Install source from a custom url to a custom install_destination path.
  The following parameters apply both for "source" and "puppi" install methods.
  Puppi method may be used to manage deployment updates (given the $install_source is updated).
  By default install_source is set to upstream developer and install_destination to Web (App) server document root
  Pre and post installation commands may be already defined (check logstash/manifests/params.pp) override them only if needed.
  Url_check and url_pattern are used for application checks, if monitor is enabled. Override only if needed.

        class { "logstash":
          install             => "source",
          install_source      => "http://deploy.example42.com/logstash/logstash-jar",
        }

* Remove logstash

        class { "logstash":
          absent => true
        }

* Enable auditing without without making changes on existing logstash configuration files

        class { "logstash":
          audit_only => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { "logstash":
          source => [ "puppet:///modules/lab42/logstash/wp-config.php-${hostname}" , "puppet:///modules/lab42/logstash/wp-config.php" ], 
        }


* Use custom source directory for the whole configuration dir

        class { "logstash":
          source_dir       => "puppet:///modules/lab42/logstash/conf/",
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file 

        class { "logstash":
          template => "example42/logstash/wp-config.php.erb",      
        }

* Automaticallly include a custom subclass

        class { "logstash:"
          my_class => 'logstash::example42',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)
  Note that this option requires the usage of Example42 puppi module

        class { "logstash": 
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with
  a puppi::helper define ) to customize the output of puppi commands 

        class { "logstash":
          puppi        => true,
          puppi_helper => "myhelper", 
        }

* Activate automatic monitoring (recommended, but disabled by default)
  This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { "logstash":
          monitor      => true,
          monitor_tool => [ "nagios" , "puppi" ],
        }


[![Build Status](https://travis-ci.org/example42/puppet-logstash.png?branch=master)](https://travis-ci.org/example42/puppet-logstash)
