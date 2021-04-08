#!/bin/sh

if [ -n "$PYPI_INDEX_URL" ]; then
	pip3 config set global.index-url $PYPI_INDEX_URL
fi
service postgresql start
service redis-server start
/usr/sbin/sshd -D
