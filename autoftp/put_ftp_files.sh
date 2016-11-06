#!/bin/sh
#将一个或多个文件传输到远程计算机
REMOTEFILES=$1

THISSCRIPT=$(basename $0)
RNODE="localhost"
USER="hongda"
UPASSWD="admin123"
LOCALDIR="/home/hongda/myzone/downloads"
REMOTEDIR="Ushell"

case $SHELL in 
    */bin/bash) alias echo="echo -e"
        ;;
esac

pre_event()
{
    #预处理函数
    :
}

post_event()
{
    #后处理函数
    :
}

usage()
{
    echo "\nUsage: $THISSCRIPT \"One or more filename to Upload\" \n"
    exit 1

}

usage_error()
{
    echo "\nError: This shell script requires a list of one or more files to upload to the remote site.\n"
    usage
}

(($# != 1)) && usage_error

pre_event

ftp -i -v -n $RNODE <<END_FTP

user $USER $UPASSWD
binary
lcd $LOCALDIR
cd $REMOTEDIR
mput $REMOTEFILES
bye

END_FTP

post_event

