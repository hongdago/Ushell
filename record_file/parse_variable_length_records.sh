#!/bin/sh
#处理变长记录文件
function parse_variable_length_records
{
    >$OUTFILE

    exec 1<&4
    exec 1>$OUTFILE

    while read RECORD
    do

        echo $RECORD | awk -F : '{print $1 $2 $3 $$ $5}' \
            |while read BRANCH ACCOUNT NAME TOTAL DATEDUE
        do
            #process_data $BRANCH $ACCOUNT $NAME $TOTAL $DATEDUE
            echo $BRANCH $ACCOUNT $NAME $TOTAL $DATEDUE
            if (( $? !=0))
            then
                echo "Record Error :  $RECORD" | tee -a $LOGFILE
            fi
        done
    done<$INFILE

    exec 1<&4
    exec 4>&-
}
