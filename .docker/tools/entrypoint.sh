#!/bin/bash

set -e

: ${XDEBUG:=0}
: ${LOCAL_IP:=none}
: ${RED:='\033[0;31m'}
: ${GREEN:='\033[0;32m'}
: ${NOCOLOR:='\033[0m'}

export PATH=$PATH:/var/www/html/node_modules/.bin

# Change www-data's uid & guid to be the same as directory in host or the configured one
# Fix cache problems
sed -ie "s/`id -u www-data`:`id -g www-data`/`stat -c %u /var/www/html`:`stat -c %g /var/www/html`/g" /etc/passwd

# Execute all commands with user www-data except for superuser access 'su'
if [ "$1" = "su" ]; then
    /bin/bash -c "${*:2}"
elif [ "$1" = "bash" -o "$*" = "xdebug" ]; then
    su www-data
elif [ "$1" = "themeps" ]; then
    echo Prestashop theme = $THEME_PS
    cd themes/$THEME_PS/_dev && su www-data -s /bin/bash -c "${*:2}"
else
    su www-data -s /bin/bash -c "$*"
fi
