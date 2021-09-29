#!/bin/bash

readonly CWD=$(dirname $0)

rm -f /tmp/profile/*
rm -f /var/log/mysql/mysql-slow.log
rm -f /var/log/nginx/access.log

${CWD}/restart.sh

