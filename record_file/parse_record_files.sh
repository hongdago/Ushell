#!/bin/sh
#解析记录文件

#验证输入
if (($# != 1))
then
    echo -e "\nUSAGE: $(basename $0) -f|-v"
    echo -e "\nWhere -f = fixed-length records"
    echo -e "\nand -v = variable-length records\n"
    exit 1
else
    case $1 in
        -f) RECORED_TYPE=fixed
            ;;
        -v) RECORED_TYPE=variable
            ;;
        *) echo -e "\nUSAGE: $(basename $0) -f|-v"
            echo -e "\nWhere -f = fixed-length records"
            echo -e "\nand -v = variable-length records\n"
            exit 1
            ;;
    esac
fi


#定义文件变量
DATADIR=$(pwd)  #定义数据文件目录

if [ $RECORED_TYPE = fixed ]
then
    MERGERECORDFILE=${DATADIR}/mergedrecord_fixed.$(date +%m%d%y)
    >$MERGERECORDFILE
    RECORDFILELIST=${DATADIR}/branch_records_fixed.lst
    OUTFILE=${DATADIR}/post_processing_fixed_records.dat
    >$OUTFILE
else
    MERGERECORDFILE=${DATADIR}/mergedrecord_variable.$(date +%m%d%y)
    >$MERGERECORDFILE
    RECORDFILELIST=${DATADIR}/branch_records_variable.lst
    OUTFILE=${DATADIR}/post_processing_variable_records.dat
    >$OUTFILE
fi

#对于solaris awk的特殊处理
case $(uname) in
    SunOS) alias awk=nawk
        ;;
esac

FD=:
NEW_DATADUE=01312008

function process_fixedlength_data_new_duedate
{
    branch=$1
    account=$2
    name=$3
    total=$4
    datedue=$5
    recfile=$6
    new_datedue=$7

    echo "${branch}${account}${name}${total}${new_datedue}${recfile}" >>$OUTFILE
}

function process_variablelength_data_new_duedate
{
    branch=$1
    account=$2
    name=$3
    total=$4
    datedue=$5
    recfile=$6
    new_datedue=$7

    echo "${branch}${FD}${account}${FD}${name}${FD}${total}${FD}${new_datedue}${FD}${recfile}" >>$OUTFILE
}

function  merge_fixed_length_records
{
    while read RECORDFILENAME
    do
        sed s/$/$(basename $RECORDFILENAME 2>/dev/null)/g $RECORDFILENAME >> $MERGERECORDFILE
    done < $RECORDFILELIST
}


function merge_variable_length_records
{
    while read RECORDFILENAME
    do
        sed s/$/${FD}$(basename $RECORDFILENAME 2>/dev/null)/g $RECORDFILENAME >> $MERGERECORDFILE
    done < $RECORDFILELIST
}


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
        RECFILE=$(echo "$RECORD" | cut -c79-)

        process_fixedlength_data_new_duedate $BRANCH $ACCOUNT $NAME $TOTAL $DUEDATE $RECFILE $NEW_DATADUE
        if (($? != 0))
        then
            ehco "Record Error: $RECORD" | tee -a $LOGFILE
        fi
    done < $MERGERECORDFILE

    exec 1<&4
    exec 4>&-
}


function parse_variable_length_records
{
    >$OUTFILE

    exec 4<&1
    exec 1>$OUTFILE

    while read RECORD
    do
        echo $RECORD | awk -F: '{print $1,$2,$3,$4,$5,$6}'\
            |while read BRANCH ACCOUNT NAME TOTAL DATEDUE RECFILE
        do
            process_variablelength_data_new_duedate $BRANCH $ACCOUNT $NAME $TOTAL $DUEDATE $RECFILE $NEW_DATADUE
            if (($? != 0))
            then
                ehco "Record Error: $RECORD" | tee -a $LOGFILE
            fi
        done
    done <$MERGERECORDFILE

    exec 1<&4
    exec 4>&-
}


#MAIN 
case $RECORED_TYPE in
    fixed) merge_fixed_length_records
        parse_fixed_length_records
        ;;
    variable) merge_variable_length_records
        parse_variable_length_records
        ;;
esac
