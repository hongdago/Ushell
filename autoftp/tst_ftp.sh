#!/bin/bash
#实现简单FTP传输
ftp -i -n -v localhost <<END_FTP
user hongda admin123
binary
lcd ~/myzone/downloads/
cd Ushell/autoftp
get tst_ftp.sh
bye

END_FTP
