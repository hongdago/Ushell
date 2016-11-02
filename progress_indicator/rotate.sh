#!/bin/sh
#进度指示器：旋转线
function rotate
{
    INTERVAL=1 #sleep time between rotation intervals
    RCOUNT="0"

    while :
    do
        ((RCOUNT=RCOUNT + 1))
        case $RCOUNT in
            1) echo -e '—'"\b\c"
                sleep $INTERVAL
                ;;
            2) echo -e '\\'"\b\c"
                sleep $INTERVAL
                ;;
            3) echo -e "|\b\c"
                sleep  $INTERVAL
                ;;
            4) echo -e "/\b\c"
                sleep $INTERVAL
                ;;
            *) RCOUNT="0" #reset the RCOUNT 
                ;;
        esac
    done
}

rotate &
BG_PID=$!

#模拟执行脚本
sleep 20
kill -9 $BG_PID

#清理屏幕
echo  -e "\b\b"
