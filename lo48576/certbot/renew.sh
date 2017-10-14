#!/bin/sh

# Renew the cert.

cd "$(dirname "$0")"

VOLUMES=".."
DYNAMIC_VOLUMES="${VOLUMES}/dynamic"
DOMAIN="${1:-"${DOMAIN:-}"}"

if [ -z "${DOMAIN}" ] ; then
    echo 'DOMAIN envvar or argument $1 is required' >&2
    exit 1
fi

docker pull certbot/certbot
docker run --rm \
    -v "${DYNAMIC_VOLUMES}/certbot/etc-letsencrypt:/etc/letsencrypt" \
    -v "${DYNAMIC_VOLUMES}/certbot/var-lib-letsencrypt:/var/lib/letsencrypt" \
    -v "${DYNAMIC_VOLUMES}/certbot/var-log-letsencrypt:/var/log/letsencrypt" \
    -v "${DYNAMIC_VOLUMES}/nginx/html:/tmp/html" \
    certbot/certbot renew --webroot -w /tmp/html
