#!/bin/bash
apt-get -y install puppet puppetmaster
cp -r puppet/ /etc/puppet/
puppet agent --test
