#!/bin/sh
#inpath - Verifies that a specified progoram is either valid as is,
# or that it can be found in the PATH directory list.
inpath()
{
    cmd=$1
    path=$2
    retval=1
    oldIFS=$IFS
    IFS=":"
    for directory in $path
    do
        if [ -x ${directory}/${cmd} ]
        then
            retval=0
        fi
    done
    IFS=$oldIFS
    return $retval
}

checkForCmdInPath()
{
    var=$1
    if [ "$var" != "" ]
    then
        if [ "${var%${var#?}}" = "/" ]
        then
            if [ ! -x $var ]
            then
                return 1
            fi
        elif ! inpath $var $PATH
        then
            return 2
        fi
    fi
}

if [ $# -ne 1 ]
then
    echo "Usage:$(basename $0) command" >&2
    exit 1
fi

checkForCmdInPath "$1"
case $? in 
    0) echo "$1 found in PATH"
        ;;
    1) echo "$1 not found or not executable"
        ;;
    2) echo "$1 not foune in PATH"
        ;;
esac
    
