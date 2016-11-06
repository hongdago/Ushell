#!/bin/sh
#说明变量可见范围的shell脚本 setpwenv.sh

case $SHELL in
    */bin/bash) alias echo="echo -e"
        ;;
esac

#set the bin directory (setpwenv.sh  所在的目录)
BINDIR=$(dirname setpwenv.sh)

. ${BINDIR}/setpwenv.sh


echo "\n\nPASS is $MYPWDTST"   #display the passwoed contained in the variable

echo "\nSearching for the password in the environment..."

env | grep MYPWDTST

if (($? == 0))
then
    echo "\nERROR: Password was found in the environment\n\n"
else
    echo "\nSUCCESS: Password was not found in the environment\n\n"
fi
