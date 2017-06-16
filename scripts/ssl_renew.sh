#!/usr/bin/env bash

# renew certificates for https (ssl offloading by haproxy)

set -e

DOMAINS="nodraak.fr,blog.nodraak.fr,cv.nodraak.fr,git.nodraak.fr,www.nodraak.fr,me.nodraak.fr"
DOMAIN_NAME='nodraak.fr'
EMAIL="adrienchardon@mailoo.org"
KEY_SIZE="4096"
CHALLENGE_PORT="10099"  # should be redirected by haproxy

function post_update ()
{
    echo "cat..."
    cat /etc/letsencrypt/live/$DOMAIN_NAME/fullchain.pem \
            /etc/letsencrypt/live/$DOMAIN_NAME/privkey.pem \
            > /etc/haproxy/nodraak.fr.pem
    echo "chmod..."
    chmod 400 /etc/haproxy/nodraak.fr.pem

    echo "check.."
    haproxy -c -f /etc/haproxy/haproxy.cfg

    echo "reload..."
    service haproxy reload
}

function main ()
{
   echo "--------------------------------------"
   date

   certbot certonly \
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

   post_update

   date
   echo "--------------------------------------"
}

main

