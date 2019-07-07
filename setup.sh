#!/bin/bash

echo "Welcome to Dockarr!"

mkdir -p ./nginx/sites-enabled
# This will resolve nginx's dependency on that
# directory since letsencrypt wont have created it
# when you run docker-compose the first time.
mkdir -p ./letsencrypt/certs

# Some other folders we'll be using.
mkdir -p qbittorrent

mkdir -p radarr
echo '<Config><UrlBase>/radarr</UrlBase></Config>' > ./radarr/config.xml

mkdir -p sonarr
echo '<Config><UrlBase>/sonarr</UrlBase></Config>' > ./sonarr/config.xml

echo "What domain would you like to use? Remember, it has to be managed through Cloudflare."
read -p 'Domain name:' SETUP_DOMAIN
echo $SETUP_DOMAIN >> ./letsencrypt/domains.txt

echo "Great. Lets set up a username and password for Nginx. These will be used to access the Dockarr services."

read -p 'Username:' SETUP_USER
read -p 'Password:' SETUP_PASS
echo "$SETUP_USER:{PLAIN}$SETUP_PASS" >> ./nginx/htpasswd

# Something to replace the default values in the nginx conf without trashing stuff like $uri
#echo '$PATH $HOSTNAME' | envsubst '$HOSTNAME' >&1
export SETUP_DOMAIN=$SETUP_DOMAIN
envsubst '$SETUP_DOMAIN' < nginx/dockarr-proxy-template.conf > nginx/sites-enabled/dockarr-proxy

echo "You're all set! You can boot your new Dockarr setup by running 'docker-compose up'"
