#!/bin/bash

VAGRANT_CORE_FOLDER=$(cat '/.puphpet-stuff/vagrant-core-folder.txt')
DEFAULT_VHOST=$VAGRANT_CORE_FOLDER"/files/exec-always/000-default.conf"

cp "$DEFAULT_VHOST" /etc/apache2/sites-available/000-default.conf
a2ensite 000-default.conf
service apache2 reload
