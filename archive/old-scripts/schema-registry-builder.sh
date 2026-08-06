#!/data/data/com.termux/files/usr/bin/bash

echo "Building schema registry..."

grep -R "create table" . \
--include="*.sql" \
| sed 's/.*create table if not exists //I' \
| sed 's/(.*//' \
| tr -d '"' \
| sort -u > database/all-known-tables.txt


echo "Schema list created:"
cat database/all-known-tables.txt

