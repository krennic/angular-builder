#!/bin/bash -e

#workaround karma
/etc/init.d/xvfb start && sleep 2

exec "$@"
