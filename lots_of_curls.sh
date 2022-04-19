#!/bin/sh

rm -f results.log

for i in {1..5}
do
    # ../wget -T 15 -t 1 -a output-file.txt --background $1
    ../wget -T 15 -t 1 -a wget-log -b -nv --header="Request-Time: $(date +"%s")" $1
done

sleep 30s

cat wget-log > results.log
echo "" >> results.log
echo "" >> results.log
cat index.html* >> results.log

rm -f index.html*
rm -f wget-log