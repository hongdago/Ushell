#!/bin/bash
# 测试逐行处理文件的24种方法的运行时间
INFILE=$1
OUTFILE=writefile.out
TIMEFILE="/tmp/loopgile.out"
>$TIMEFILE
THIS_SCRIPT=$(basename $0)


function usage
{
    echo -e "\nUSAGE: $THIS_SCRIPT file_to_process\n"
    echo "OR - To send the output to a file use: "
    echo -e "\n$THIS_SCRIPT file_to_process > output_file_name 2>&1 \n"
    exit 1
}


function verify_files
{
    diff $INFILE $OUTFILE >/dev/null 2>&1
    if (($? != 0))
    then
        echo "ERROR: $INFILE and $OUTFILE do not match"
        ls -l $INFILE $OUTFILE
    fi
}

#引入24种方法
. file_process_pre_line.sh


(($# == 1)) || usage

[[ -f $1 ]] || usage

echo -e "\nStarting File Processing of each Method\n"

echo -e "Method 1:"
echo "function cat_while_read_line"
time cat_while_read_line 
verify_files
sleep 1

echo -e "\nMethod 2:"
echo "function while_read_LINE_bottom"
time while_read_LINE_bottom
verify_files
sleep 1

echo -e "\nMethod 3:"
echo "function cat_while_LINE_line"
time cat_while_LINE_line
verify_files
sleep 1


echo -e "\nMethod 4:"
echo "function while_LINE_line_bottom"
time while_LINE_line_bottom
verify_files
sleep 1


echo -e "\nMethod 5:"
echo "function cat_while_LINE_line_cmdsub2"
time cat_while_LINE_line_cmdsub2
verify_files
sleep 1


echo -e "\nMethod 6:"
echo "function while_LINE_line_bottom_cmdsub2"
time while_LINE_line_bottom_cmdsub2
verify_files
sleep 1



echo -e "\nMethod 7:"
echo "function for_LINE_cat_file"
time for_LINE_cat_file
verify_files
sleep 1


echo -e "\nMethod 8:"
echo "function for_LINE_cat_file_cmdsub2"
time for_LINE_cat_file_cmdsub2
verify_files
sleep 1



echo -e "\nMethod 9:"
echo "function while_line_outfile"
time while_line_outfile
verify_files
sleep 1


echo -e "\nMethod 10:"
echo "function while_read_LINE_FD_IN"
time while_read_line_FD_IN 
verify_files
sleep 1


echo -e "\nMethod 11:"
echo "function cat_while_read_LINE_FD_OUT"
time cat_while_read_LINE_FD_OUT 
verify_files
sleep 1


echo -e "\nMethod 12:"
echo "function while_read_LINE_bottom_FD_OUT"
time while_read_LINE_bottom_FD_OUT 
verify_files
sleep 1


echo -e "\nMethod 13:"
echo "function while_LINE_line_bottom_FD_OUT"
time while_LINE_line_bottom_FD_OUT 
verify_files
sleep 1

echo -e "\nMethod 14:"
echo "function while_LINE_line_bottom_cmdsub2_FD_OUT"
time while_LINE_line_bottom_cmdsub2_FD_OUT
verify_files
sleep 1



echo -e "\nMethod 15:"
echo "function for_LINE_cat_FILE_FD_OUT"
time for_LINE_cat_FILE_FD_OUT
verify_files
sleep 1


echo -e "\nMethod 16:"
echo "function for_LINE_cat_FILE_cmdsub2_FD_OUT"
time for_LINE_cat_FILE_cmdsub2_FD_OUT
verify_files
sleep 1



echo -e "\nMethod 17:"
echo "function while_line_outfile_FD_IN"
time while_line_outfile_FD_IN
verify_files
sleep 1


echo -e "\nMethod 18:"
echo "function while_line_outfile_FD_OUT"
time while_line_outfile_FD_OUT
verify_files
sleep 1



echo -e "\nMethod 19:"
echo "function while_line_outfile_FD_IN_AND_OUT"
time while_line_outfile_FD_IN_AND_OUT
verify_files
sleep 1


echo -e "\nMethod 20:"
echo "function while_LINE_line_FD_IN"
time while_LINE_line_FD_IN
verify_files
sleep 1


echo -e "\nMethod 21:"
echo "function while_LINE_line_cmdsub2_FD_IN"
time while_LINE_line_cmdsub2_FD_IN
verify_files
sleep 1


echo -e "\nMethod 22:"
echo "function while_read_LINE_FD_IN_AND_OUT"
time while_read_LINE_FD_IN_AND_OUT 
verify_files
sleep 1


echo -e "\nMethod 23:"
echo "function while_LINE_line_FD_IN_AND_OUT"
time while_LINE_line_FD_IN_AND_OUT
verify_files
sleep 1


echo -e "\nMethod 24:"
echo "function while_LINE_line_cmdsub2__FD_IN_AND_OUT"
time while_LINE_line_cmdsub2__FD_IN_AND_OUT
verify_files

