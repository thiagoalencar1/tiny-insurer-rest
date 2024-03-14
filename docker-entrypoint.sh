#!/bin/bash

set -xe
echo "entrypoint.sh: Removing server.pid"
rm -f tmp/pids/server.pid
echo "entrypoint.sh: Running bin/setup"
bin/setup
echo "entrypoint.sh: Running exec"
exec "$@"
