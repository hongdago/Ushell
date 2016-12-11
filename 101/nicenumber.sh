#!/bin/sh
#nicenumber.sh --Give a number,shows it in comma-sepatated form.
nicenumber()
{
    integer=$(echo $1| cut -d. -f1)
    decimal=$(echo $1| cut -d. -f2)

    if [ $decimal != $1 ];then
        #There's a faction part,so let's include it.
        result="${DD:="."}$decimal"
    fi

    thousands=$integer

    while [ $thousands -gt 999 ];do
        remainder=$(($thousands % 1000))

        while [ ${#remainder} -lt 3 ];do
            remainder="0$remainder"
        done

        thousands=$(($thousands / 1000))
        result="${TD:=","}${remainder}${result}"
    done

    nicenum="${thousands}${result}"
    if [ ! -z $2 ];then
        echo $nicenum
    fi
}

DD="."
TD=","

while getopts "d:t:" opt;do
    case $opt in 
    d) DD="$OPTARG";;
    t) TD="$OPTARG" ;;
esac
done
shift $(($OPTIND -1))

if [ $# -eq 0 ];then
    echo "Usage: $(basename $0) [-d c] [-t c] numric  value"
    echo " -d specifies the dicimal point delimiter"
    echo " -t specifies the thousands delimiter"
    exit 0
fi

nicenumber $1 1
exit 0
