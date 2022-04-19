#!/bin/sh

for i in {1..20}
do
    wget localhost:8080 -T 8 -t 1 -a output-file.txt --background
done

sleep 30s

cat index.html* > all.log
rm index.html*