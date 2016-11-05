#!/bin/bash
#定长记录文件的合并
MERGERRECORDFILE=/data/megerrecord.$(date +%m%d%y)
RECORDFILELIST=/data/branch_records.lst

while read RECORDFILENAME
do
    sed s/$/$(basename $RECORDFILENAME)/g $RECORDFILENAME >> $MERGERRECORDFILE
done < $RECORDFILELIST

