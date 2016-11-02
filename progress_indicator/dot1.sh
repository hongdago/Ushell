#!/bin/sh
#进度指示器，圆点
while true
do
    echo -e ".\c"
    sleep 5 
done &

BG_PID=$!

#模拟脚本执行
sleep 60

kill $BG_PID
echo
