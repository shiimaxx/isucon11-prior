#!/bin/bash

export PATH=${PATH}:/usr/local/bin

cat /var/log/nginx/access.log | kataribe -f /opt/kataribe.toml > /opt/logs/access-totalize.log
pt-query-digest --explain "h=localhost" /var/log/mysql/mysql-slow.log > /opt/logs/slowquery-totalize.log
mysqltuner > /opt/logs/mysqltuner 2>/dev/null

