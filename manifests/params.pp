class consul::params {
    $consul_dist_url = 'https://releases.hashicorp.com/consul'
    $package_version = '0.8.0'
    $binary_zip_name = 'linux_amd64.zip'
    $webui_zip_name = 'web_ui.zip'

    $consul_user = 'consul'
    $consul_group = 'consul'

    $consul_limit_nofile = '999999'

    $bin_dir = '/usr/local/bin'
    $config_dir = '/etc/consul'
    $content_dir = '/var/consul'
    $data_dir = '/var/consul/data'
    $webui_dir = '/var/consul/webui'
    $webui_dist_dir = '/var/consul/webui/dist'
    
    $log_dir = '/var/log/consul'
    $log_file = '/var/log/consul/consul.log'
    $backup_log_file = '/var/log/consul/backup.log'
    
    $logrotate_consul_conf_file = '/etc/logrotate.d/consul'
}
