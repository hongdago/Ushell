#!/bin/sh
#进度指示器

function dots
{
    SEC=$1
    while true
    do
        echo -e ".\c"
        sleep $SEC
    done
}

dots 5 &
BG_PID=$!

#模拟脚步执行
sleep 50

kill $BG_PID
echo
