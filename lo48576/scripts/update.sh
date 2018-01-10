#!/bin/sh

cd "$(dirname "$0")"
cd ../../

# If you don't customize Dockerfile, no need to `build` containers.
# Everything required is prepared by `pull`.
docker-compose -f docker-compose.yml -f docker-compose.override.10-network.yml -f docker-compose.override.20-reverse-proxy.yml -f docker-compose.override.30-options.yml pull
# `docker-compose ... build` here, if you need.
docker-compose -f docker-compose.yml -f docker-compose.override.10-network.yml -f docker-compose.override.30-options.yml run --rm web bin/rails db:migrate
docker-compose -f docker-compose.yml -f docker-compose.override.10-network.yml -f docker-compose.override.30-options.yml run --rm web bin/rails assets:precompile
