#!/bin/bash

set -e

readonly CWD=$(dirname $0)

export GOOS=linux
export GOARCH=amd64

export HOST=isucon11-prior

rm -f webapp/golang/bin/webapp; cd webapp/golang; make; cd ../..

for i in 1; do
# for i in {1..3}; do
  ssh ${HOST} "sudo systemctl stop nginx.service web-golang.service mysql.service"
  # rsync -av env.sh ${HOST}:~/env.sh
  rsync -av webapp/golang/bin/webapp ${HOST}:~/webapp/golang/bin/webapp
  rsync -av --rsync-path="sudo rsync" conf/nginx.conf ${HOST}:/etc/nginx/nginx.conf
  rsync -av --rsync-path="sudo rsync" conf/mysqld.cnf ${HOST}:/etc/mysql/mysql.conf.d/mysqld.cnf
  rsync -av webapp/sql/ ${HOST}:~/webapp/sql/
  ssh ${HOST} "sudo systemctl start mysql.service web-golang.service nginx.service"
done

