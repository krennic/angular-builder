#!/bin/bash -e

#workaround karma
if [ "$ENABLE_FF" == "TRUE"]; then
	/etc/init.d/xvfb start && sleep 2
fi

exec "$@"
