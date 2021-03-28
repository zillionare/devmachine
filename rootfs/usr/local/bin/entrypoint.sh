#!/bin/sh

pg_ctl start
redis-server -D
/usr/sbin/sshd -D
