# h6-lamp-module
puppet module for installing lamp stack and few other things

This module was made for [server management course](http://terokarvinen.com/2016/aikataulu-palvelinten-hallinta-ict4tn022-1-5-op-uusi-ops-loppusyksy-2016#comment-21920)

The task was to create a puppet module that solves preferably atleast 2 bigger parts of an exam of a preceding course. I chose [this exam](http://terokarvinen.com/2016/arvioitava-laboratorioharjoitus-%e2%80%93-linux-palvelimena-ict4tn003-20-ilta-kevaalla-2016) for this task.

This module installs munin to monitor resource usage on the computer and enables the firewall with the necessary holes in it for ssh, http and https.

the module also installs all the necessary packages for developing php websites from offsite, however it does not create or maintain users for the system.

To complete this task I Followed the same prosedure as in my previous reports([here](https://vesalinux.wordpress.com/) and [here](https://github.com/wikkii/index-module)).


###links/sources

http://terokarvinen.com/2016/aikataulu-palvelinten-hallinta-ict4tn022-1-5-op-uusi-ops-loppusyksy-2016
http://terokarvinen.com/2016/arvioitava-laboratorioharjoitus-%e2%80%93-linux-palvelimena-ict4tn003-20-ilta-kevaalla-2016
https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
