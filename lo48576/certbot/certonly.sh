#!/bin/sh

# Gets a new cert.

cd "$(dirname "$0")"

VOLUMES=".."
DYNAMIC_VOLUMES="${VOLUMES}/dynamic"
DOMAIN="${1:-"${DOMAIN:-}"}"

if [ -z "${DOMAIN}" ] ; then
    echo 'DOMAIN envvar or argument $1 is required' >&2
    exit 1
fi

mkdir -p "${DYNAMIC_VOLUMES}/certbot/etc-letsencrypt"
mkdir -p "${DYNAMIC_VOLUMES}/certbot/var-lib-letsencrypt"
mkdir -p "${DYNAMIC_VOLUMES}/certbot/var-log-letsencrypt"
mkdir -p "${DYNAMIC_VOLUMES}/nginx/html/certbot"

docker pull certbot/certbot
docker run -it \
    -v "${DYNAMIC_VOLUMES}/certbot/etc-letsencrypt:/etc/letsencrypt" \
    -v "${DYNAMIC_VOLUMES}/certbot/var-lib-letsencrypt:/var/lib/letsencrypt" \
    -v "${DYNAMIC_VOLUMES}/certbot/var-log-letsencrypt:/var/log/letsencrypt" \
    -v "${DYNAMIC_VOLUMES}/nginx/html:/tmp/html" \
    certbot/certbot certonly --webroot -w /tmp/html -d "${DOMAIN}"
#    certbot/certbot certonly --agree-tos --email 'who@example.com' --webroot -w /tmp/html -d "${DOMAIN}"
#sudo openssl dhparam 2048 -out /etc/letsencrypt/live/dhparam_2048_20161002.pem
#sudo openssl dhparam 2048 -out /etc/letsencrypt/dhparam_2048_$(date '+%Y%m%d').pem
