#!/bin/sh

for i in {1..50}
do
    # ../wget -T 15 -t 1 -a output-file.txt --background $1
    ../wget -T 3 -t 1 -a wget-log -b -nv --header="Request-Time: $(date +"%s")" $1
done

sleep 5s

echo ""
echo "WGET logs:"
cat wget-log
echo ""
echo "Responses:"
cat index.html*

rm -f index.html*
rm -f wget-log