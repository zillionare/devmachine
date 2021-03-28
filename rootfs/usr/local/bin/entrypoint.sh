#!/bin/sh

service postgresql start
service redis-server start
/usr/sbin/sshd -D