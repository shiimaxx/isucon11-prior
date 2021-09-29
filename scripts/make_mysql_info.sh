#!/bin/bash

LF=$(printf '\\\012_')
LF=${LF%_}
database=$1

list=$(mysql -u root -e "show tables;" -B -N isucon)

echo ${list}

for i in ${list};do
  echo "[*** table: ${i} ]"
  echo "[** show create table]"
  echo '```'
  mysql -u root  -e "show create table $i" -B -N ${database}|sed 's/\\n/'"$LF"'/g'
  echo ""
  echo '```'
  echo "[** show create index]"

  echo '```'
  mysql -u root  -e "show index from $i" -B -N ${database}|sed 's/\\n/'"$LF"'/g'

  echo '```'
done

