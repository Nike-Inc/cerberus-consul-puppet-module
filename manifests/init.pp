# == Class: consul
#
# Generic init class for consul

class consul (
  $package_version = $consul::params::package_version,
  $bootstrap_expect = $consul::params::bootstrap_expect,
  $consul_run_mode
) inherits consul::params {
    if ( $consul_run_mode == 'agent' ) {
        $is_server = false
    } elsif ( $consul_run_mode == 'server' ) {
        $is_server = true
    } else {
        fail("consul_run_mode must be defined as 'agent' or 'server'")
    }
    
    if $is_server {
        $config_file_name = 'consul-server-config.json'
    } else {
        $config_file_name = 'consul-client-config.json'
    }
    
    include consul::install
    include consul::config
}
