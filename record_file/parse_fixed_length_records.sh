#!/bin/sh
#解析定长记录文件
#记录文件结构 1～6 机构 7～25账号 26～45名称 46～70 总额 71～76 注册时间
function parse_fixed_length_records
{
    >$OUTFILE

    exec 4<&1
    exec 1>$OUTFILE

    while read RECORD
    do
        BRANCH=$(echo "$RECORD" | cut -c1-6)
        ACCOUNT=$(echo "$RECORD" | cut -c7-25)
        NAME=$(echo "$RECORD" | cut -c26-45)
        TOTAL=$(echo "$RECORD" | cut -c46-70)
        DUEDATE=$(echo "$RECORD" | cut -c71-78)

        #process_data $BRANCH $ACCOUNT $NAME $TOTAL $DUEDATE
        echo $BRANCH $ACCOUNT $NAME $TOTAL $DUEDATE
        if (($? != 0))
        then
            echo "Record Error: $RECORD " | tee -a $LOGFILE
        fi
    done < $INFILE

    exec 1<&4
    exec 4>&-

}
