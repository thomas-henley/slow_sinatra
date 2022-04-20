for i in {1..50}
do
    # ../wget -T 15 -t 1 -a output-file.txt --background $1
    ../wget -T 15 -t 1 -nv -O- $1
    sleep 0.5s
done