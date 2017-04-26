#!/bin/bash -e

#workaround karma
if [ "$ENABLE_FF" == "TRUE" ]; then
	/etc/init.d/xvfb start && sleep 5
fi

#npm login
if [ -n "$NPM_URL" && -n "$NPM_TOKEN" ]; then
	echo -e "$NPM_URL/repository/npm-snapshots/:_authToken=$NPM_TOKEN\n$NPM_URL/repository/npm-releases/:_authToken=$NPM_TOKEN" > /root/.npmrc
fi

exec "$@"
