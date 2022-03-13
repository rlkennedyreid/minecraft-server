#!/usr/bin/env bash

set -euxo pipefail

echo "eula=${EULA}" > eula.txt

exec java @/etc/jvm.options -jar /opt/server.jar --nogui
