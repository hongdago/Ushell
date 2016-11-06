#!/bin/sh
#使用FTP获取远程计算机上的目录列表
RNODE="localhost"
USER="hongda"
UPASSWD="admin123"
LOCALDIR="/home/hongda/myzone/downloads"
REMOTEDIR="Ushell"

DIRLISTFILE="${LOCALDIR}/${RNODE}.$(basename ${REMOTEDIR}).dirlist.out"
touch  $DIRLISTFILE

ftp -i -v -n $RNODE <<END_FTP
user $USER $UPASSWD
nlist $REMOTEDIR  $DIRLISTFILE
bye

END_FTP
