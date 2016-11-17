class lamp {
	#exec {'apt-update':
	#command => '/usr/bin/apt-get update'
	#}
	
	$mysqlpw = "pwerman9222!"
		
	package { 'ssh':
	#require => Exec['apt-update'],
  	ensure => 'installed',
	}
	package { 'munin':
  	#require => Exec['apt-update'],
	ensure => 'installed',
	}
	package {'apache2':
	#require => Exec['apt-update'],
	ensure => 'installed',
	}
	package { 'mysql-server':
 	#require => Exec['apt-update'],
	ensure => 'installed',
	}
	package { 'mysql-client':
	#require => Exec['apt-update'],
 	ensure => 'installed',
	}
	package { 'php':
 	#require => Exec['apt-update'],
	ensure => 'installed',
	}
	package { 'libapache2-mod-php':
  	#require => Exec['apt-update'],
	ensure => 'installed',
	}
	package { 'python':
 	#require => Exec['apt-update'],
	ensure => 'installed',
	}
	package { 'gedit':
  	#require => Exec['apt-update'],
	ensure => 'installed',
	}
	package { 'curl':
 	#require => Exec['apt-update'],
	ensure => 'installed',
	}
	package { 'php-mysql':
  	#ensure => 'installed',
	require => Exec['apt-update'],
	}
	package { 'htop':
  	#ensure => 'installed',
	require => Exec['apt-update'],
	}
	
	file { '/etc/apache2/mods-enabled/userdir.conf':
  	ensure => 'link',
  	target => '../mods-available/userdir.conf',
	notify => Service['apache2'],
	require => Package['apache2'],
	}

	file { '/etc/apache2/mods-enabled/userdir.load':
  	ensure => 'link',
  	target => '../mods-available/userdir.load',
	notify => Service["apache2"],
	require => Package['apache2'],
	}

	file { '/etc/apache2/mods-available/php7.0.conf':
  	content=>template("lamp/php7.0.conf.erb"),
  	source=>'puppet:///modules/lamp/php7.0.conf',
	notify => Service['apache2'],
	require => Package['apache2'],
	}
	
	file { '/etc/apache2/mods-enabled/php7.0.conf':
  	ensure => 'link',
 	target => '../mods-available/php7.0.conf',
	notify => Service["apache2"],
	require => Package['apache2'],
	}

	service {'apache2':
	ensure=>"running",
	enable=>"true",
	provider => systemd,
	}

	service { 'mysql':
 	ensure => 'running',
  	enable => 'true',
	provider => systemd,
	}

	exec { 'ufw-allow-ssh':
  	command => "/usr/sbin/ufw allow ssh",
	}
	
	exec { 'ufw-allow-http':
        command => "/usr/sbin/ufw allow http",
        }
	
	exec { 'ufw-allow-https':
        command => "/usr/sbin/ufw allow https",
        }
	
	exec { 'ufw-enable':
	command => "/usr/sbin/ufw enable",
	require => Exec['ufw-allow-ssh', 'ufw-allow-http', 'ufw-allow-https'],
	}
	
        #file{'/etc/mysql/pw_created':
        #ensure=> 'present',
        #content => "file is created to stop setting mysql root password a
        #second time\n",
        #}
	
	#exec {'set-mysql-pw':
	#unless => '/usr/bin/test -f /etc/mysql/pw-created',
	#command => "/usr/bin/mysqladmin -u root password $mysqlpw",
	#require => Service["mysql"],
	#}
}
