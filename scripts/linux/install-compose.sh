#!/bin/sh
set -e

VERSION="${VERSION:-1.29.2}"
SYSTEM="$(uname -s)"
ARCH="$(uname -m)"
URL="https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-${SYSTEM}-${ARCH}"

curl -L "${URL}" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

docker-compose --version
