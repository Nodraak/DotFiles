#!/usr/bin/env bash

#
# == What do this script do? ==
# Renew TLS certificates for HTTPS offloading by haproxy
#
# == Requirements ==
# Crontab line: (runs each month at 3:00)
#     0 3 1 * * bash /root/ssl_renew.sh > /root/ssl_renew.log 2>&1
#

#
# Settings
#

DOMAINS="nodraak.fr,blog.nodraak.fr,cv.nodraak.fr,git.nodraak.fr,www.nodraak.fr,me.nodraak.fr"
DOMAIN_NAME="nodraak.fr"
EMAIL="adrienchardon@mailoo.org"
KEY_SIZE="4096"
CHALLENGE_PORT="10099"  # should be redirected by haproxy

#
# Preliminary
#

set -e

# add missing path for haproxy and service
PATH="${PATH}:/usr/sbin"

#
# Script
#

function main()
{
    certbot \
        certonly \
        --agree-tos \
        --domains $DOMAINS \
        --email $EMAIL \
        --renew-by-default \
        --rsa-key-size $KEY_SIZE \
        --text \
        --standalone --standalone-supported-challenges http-01 --http-01-port $CHALLENGE_PORT

    if [ $? -ne 0 ];
    then
        echo "*********************************"
        echo "** Error: Let's Encrypt failed **"
        echo "*********************************"
        exit 1
    fi

    echo "Saving cert for haproxy..."
    cat /etc/letsencrypt/live/$DOMAIN_NAME/fullchain.pem \
        /etc/letsencrypt/live/$DOMAIN_NAME/privkey.pem \
        > /etc/haproxy/nodraak.fr.pem
    chmod 400 /etc/haproxy/nodraak.fr.pem

    echo "Check haproxy config..."
    haproxy -c -f /etc/haproxy/haproxy.cfg

    echo "Reload haproxy..."
    service haproxy reload
}

echo "--------------------------------------"
date --rfc-3339=seconds

main

date --rfc-3339=seconds
echo "--------------------------------------"

