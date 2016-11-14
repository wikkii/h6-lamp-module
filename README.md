# h6-lamp-module
puppet module for installing lamp stack and few other things

This module was made for [server management course](http://terokarvinen.com/2016/aikataulu-palvelinten-hallinta-ict4tn022-1-5-op-uusi-ops-loppusyksy-2016#comment-21920)

The task was to create a puppet module that solves preferably atleast 2 bigger parts of an exam of a preceding course. I chose [this exam](http://terokarvinen.com/2016/arvioitava-laboratorioharjoitus-%e2%80%93-linux-palvelimena-ict4tn003-20-ilta-kevaalla-2016) for this task.

This module installs munin to monitor resource usage on the computer and enables the firewall with the necessary holes in it for ssh, http and https.

the module also installs all the necessary packages for developing php websites from offsite, however it does not create or maintain users for the system.

To complete this task I Followed the same prosedure as in my previous reports ([here](https://vesalinux.wordpress.com/) and [here](https://github.com/wikkii/index-module)).

I started the task by making this github repository and creating a new folder in my home folder on my computer.
```
mkdir lamp-stack
```

I used [this](https://vesalinux.wordpress.com/2016/11/06/h4-installation-module-for-some-fav-programs-and-their-settings/) module I had created previously as base since I had already tested it to work and it already contained some of the puppet resources needed for this task.

I added munin and ssh to the init.pp file

```
$ cd /etc/puppet/modules/lamp/
$ sudoedit manifests/init.pp
```
by adding the lines
```
	package { 'ssh':
	require => Exec['apt-update'],
  	ensure => 'installed',
	}
	package { 'munin':
  	require => Exec['apt-update'],
	ensure => 'installed',
}
```
which I got by once again using the 

```
$ puppet resource package <packagename>
```
command.

Next I needed to know which directory had the ufw comman for pupper exec resource 
```
$ which ufw
/usr/sbin/ufw
```
once I knew where to find it I simply created the resource by using the existing
```
	exec {'set-mysql-pw':
	unless => '/usr/bin/test -f /etc/mysql/pw-created',
	command => "/usr/bin/mysqladmin -u root password $mysqlpw",
	require => Service["mysql"],
  }
```
exec as an example

```
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
```
I also used https://docs.puppet.com/puppet/latest/reference/types/exec.html as a reference.

With these additions the module was complete and I tested the module with
```
sudo puppet agent --test
```


###links/sources

http://terokarvinen.com/2016/aikataulu-palvelinten-hallinta-ict4tn022-1-5-op-uusi-ops-loppusyksy-2016
http://terokarvinen.com/2016/arvioitava-laboratorioharjoitus-%e2%80%93-linux-palvelimena-ict4tn003-20-ilta-kevaalla-2016
https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
