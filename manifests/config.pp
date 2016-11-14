class consul::config inherits consul {
    file { $logrotate_consul_conf_file:
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template("consul/logrotate.conf.erb"),
        require => Class['consul::install'],
    }
    
    file { "/etc/cron.d/consul": 
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template("consul/consul.cron.erb"),
        require => Class['consul::install'],
    }

    file { '/etc/init/consul.conf':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template("consul/consul.conf.erb"),
        require => Class['consul::install'],
    }
     
    file { '/usr/local/bin/consul_dl_config':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        content => template("consul/consul_dl_config.erb"),
        require => Class['consul::install'],
    }
    
    if $is_server {
        file { '/usr/local/bin/consul_backup.py':
            ensure  => file,
            owner   => $consul_user,
            group   => $consul_group,
            mode    => '0755',
            content => template("consul/consul_backup.py.erb"),
            require => Class['consul::install'],
        }
        
        file { '/etc/init/vault_acl.conf':
            ensure  => file,
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            content => template("consul/vault_acl.conf.erb"),
            require => Class['consul::install'],
        }
        
        file { '/usr/local/bin/sync_vault_acl':
            ensure  => file,
            owner   => 'root',
            group   => 'root',
            mode    => '0755',
            content => template("consul/sync_vault_acl.erb"),
            require => Class['consul::install'],
        }
    }
}
