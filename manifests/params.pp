# == Class: puppetboard::params
#
# Defines default values for puppetboard parameters.
#
# Inherited by Class['puppetboard'].
#
class puppetboard::params {

  case $::osfamily {
    'Debian': {
      if ($::operatingsystem == ubuntu) {
        if ($::operatingsystemrelease == '14.04') {
          $apache_confd   = '/etc/apache2/conf.d'
        } else {
          $apache_confd = '/etc/apache2/conf-enabled'
        }
      } else {
      $apache_confd   = '/etc/apache2/conf.d'
      }
 
      $apache_service = 'apache2'
    }

    'RedHat': {
      $apache_confd   = '/etc/httpd/conf.d'
      $apache_service = 'httpd'
      File {
        seltype => 'httpd_sys_content_t',
      }
    }
    default: { fail("The ${::osfamily} operating system is not supported with the puppetboard module") }
  }

  $manage_selinux = $::selinux ? {
    false   => false,
    default => true,
  }

  $user  = 'puppetboard'
  $group = 'puppetboard'
  $groups = undef
  $basedir = '/srv/puppetboard'
  $git_source = 'https://github.com/voxpupuli/puppetboard'

  $puppetdb_host = 'localhost'
  $puppetdb_port = 8080
  $puppetdb_key = undef
  $puppetdb_ssl_verify = false
  $puppetdb_cert = undef
  $puppetdb_timeout = 20
  $dev_listen_host = '127.0.0.1'
  $dev_listen_port = 5000
  $unresponsive = 3
  $enable_catalog = false
  $enable_query = true
  $localise_timestamp = true
  $offline_mode = false
  $python_loglevel = 'info'
  $python_proxy = false
  $reports_count = '10'
  $experimental = false
  $revision = undef
  $virtualenv = 'python-virtualenv'
  $listen = 'private'
  $apache_override = 'None'
  $default_environment = 'production'
  $extra_settings = {}
}
