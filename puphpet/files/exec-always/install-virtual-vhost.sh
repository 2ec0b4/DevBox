#!/bin/bash

PUPHPET_CORE_DIR=/opt/puphpet
DEFAULT_VHOST=$PUPHPET_CORE_DIR"/files/exec-always/000-default.conf"

cp "$DEFAULT_VHOST" /etc/apache2/sites-available/000-default.conf
a2ensite 000-default.conf
service apache2 reload
