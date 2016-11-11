# == Class: consul::install
# Installs consul and needed conf files
class consul::install inherits consul {
    $s3_binary_url = "${consul_dist_url}/${package_version}/${binary_zip_name}"
    $s3_webui_url = "${consul_dist_url}/${package_version}/${webui_zip_name}"
    $tmp_binary_zip = "/tmp/consul.zip"
    $tmp_webui_zip = "/tmp/consul-webui.zip"
    
    package { 'ensure-jq-installed':
        name    => 'jq',
        ensure  => installed,
    }

    package { 'ensure-pycrypto-installed':
        name    => 'python-crypto',
        ensure  => installed,
    }

    package { 'boto3':
        ensure   => 'latest',
        provider => 'pip',
    }
    
    group { $consul_group:
        ensure => present,
        system => true,
    }
    
    user { $consul_user:
        ensure => present,
        system => true,
        gid    => $consul_group,
    }
    
    file { $config_dir:
        ensure => 'directory',
        owner  => $consul_user,
        group  => $consul_group,
        mode   => '0755',
    }
    
    file { [$content_dir, $data_dir]:
        ensure => 'directory',
        owner  => $consul_user,
        group  => $consul_group,
        mode   => '0755',
    }
   
    file { $log_dir:
        ensure => 'directory',
        owner  => $consul_user,
        group  => $consul_group,
        mode   => '0755',
    }->
	file { $log_file:
        ensure => present,
        owner  => $consul_user,
        group  => $consul_group,
        mode   => '0644',
    }
  
    exec { 'download consul':
        command => "/usr/local/bin/aws s3 cp ${s3_binary_url} ${tmp_binary_zip}",
    }->
    exec { 'unzip consul':
        cwd     => $bin_dir,
        command => "/usr/bin/unzip ${tmp_binary_zip} -d ${bin_dir}",
        returns => [0, 9],
        creates => "${bin_dir}/consul", # Don't run if file already exists.
    }->
    file { $tmp_binary_zip:
        ensure => absent,
    }

    file { $webui_dir:
        ensure => 'directory',
        owner  => $consul_user,
        group  => $consul_group,
        mode   => '0755',
    }->
    exec { 'download consul webui':
        command => "/usr/local/bin/aws s3 cp ${s3_webui_url} ${tmp_webui_zip}",
    }->
    exec { 'unzip consul webui':
        cwd     => $webui_dir,
        command => "/usr/bin/unzip ${tmp_webui_zip} -d ${webui_dir}",
        returns => [0, 9],
        creates => $webui_dist_dir, # Don't run if directory already exists.
    }->
    file { $tmp_webui_zip:
        ensure => absent,
    }

    file { '/usr/local/bin/s3_get_enc_object.py':
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        content => template("consul/s3_get_enc_object.py.erb"),
    }
}
