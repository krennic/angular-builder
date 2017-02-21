#!/bin/bash -e

#workaround karma
if [ -n "$ENABLE_FF"]; then
	/etc/init.d/xvfb start && sleep 2
fi

exec "$@"
