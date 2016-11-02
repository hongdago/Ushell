#!/bin/bash
#逐行处理文件的24种方法

#方法1
cat_while_read_line()
{
    >$OUTFILE
    cat $INFILE | while read LINE
    do
        echo "$LINE" >> $OUTFILE
    done
}

#方法2
function while_read_LINE_bottom()
{
    #逐行处理方法中最快的一种
    >$OUTFILE
    while read LINE
    do
        echo "$LINE" >> $OUTFILE
    done < $INFILE

}

#方法3
function cat_while_LINE_line
{
    >$OUTFILE
    cat $INFILE | while LINE=`line`
    do
        echo "$LINE" >> $OUTFILE
    done

}

#方法4
function while_LINE_line_bottom
{
    >$OUTFILE
    while LINE=`line`
    do
        echo "$LINE" >> $OUTFILE
    done < $INFILE

}

#方法5
function cat_while_LINE_line_cmdsub2
{
    >$OUTFILE
    cat $INFILE | while LINE=$(line)
    do
        echo "$LINE" >> $OUTFILE
    done
}


#方法6
function while_LINE_line_bottom_cmdsub2
{
    >$OUTFILE
    while LINE=$(line)
    do
        echo "$LINE" >> $OUTFILE
    done < $INFILE

}

#方法7
function for_LINE_cat_file
{
    >$OUTFILE
    for LINE in `cat $INFILE`
    do
        echo "$LINE" >> $OUTFILE
    done
}


#方法8
function for_LINE_cat_file_cmdsub2
{
    >$OUTFILE
    for LINE in $(cat $INFILE)
    do
        echo "$LINE" >> $OUTFILE
    done
}

#方法9
function while_line_outfile
{
    >$OUTFILE
    while read
    do
        line >> $OUTFILE
    done < $INFILE
}


#方法10
function while_read_line_FD_IN
{
     >$OUTFILE
     exec 3<&0
     exec 0<$INFILE

     while read LINE
     do
         echo "$LINE" >>$OUTFILE
     done

     exec 0<&3
     exec 3<&-
}

#方法11
function cat_while_read_LINE_FD_OUT
{
    >$OUTFILE
    exec 4<&1
    exec 1>$OUTFILE

    cat $INFILE | while read LINE
    do
        echo "$LINE"
    done

    exec 1<&4
    exec 4>&-
}


#方法12
function while_read_LINE_bottom_FD_OUT
{
    >$OUTFILE

    exec 4<&1
    exec 1>$OUTFILE

    while read LINE
    do
        echo "$LINE"
    done < $INFILE

    exec 1<&4
    exec 4>&-
}

#方法13
function while_LINE_line_bottom_FD_OUT
{
    >$OUTFILE

    exec 4<&1
    exec 1>$OUTFILE

    while LINE=`line`
    do
        echo $LINE
    done <$INFILE

    exec 1<&4
    exec 4>&-

}

#方法14
function while_LINE_line_bottom_cmdsub2_FD_OUT
{
    >$OUTFILE

    exec 4<&1
    exec 1>$OUTFILE

    while LINE=$(line)
    do
        echo $LINE
    done <$INFILE

    exec 1<&4
    exec 4>&-
}

#方法15
function for_LINE_cat_FILE_FD_OUT
{
    >$OUTFILE

    exec 4<&1
    exec 1>$OUTFILE

    for LINE in `cat $INFILE`
    do
        echo $LINE
    done

    exec 1<&4
    exec 4>&-

}

#方法16
function for_LINE_cat_FILE_cmdsub2_FD_OUT
{
    >$OUTFILE

    exec 4<&1
    exec 1>$OUTFILE

    for LINE in $(cat $INFILE)
    do
        echo $LINE
    done

    exec 1<&4
    exec 4>&-

}


#方法17
function while_line_outfile_FD_IN
{
    >$OUTFILE

    exec 3<&0
    exec 0<$INFILE

    while read
    do
        line >>$OUTFILE

    done

    exec 0<&3
    exec 3>&-
}


#方法18
function while_line_outfile_FD_OUT
{
    >$OUTFILE

    exec 4<&1
    exec 1<$OUTFILE

    while read
    do
        line 

    done < $INFILE

    exec 1<&4
    exec 4>&-
}


#方法19
function while_line_outfile_FD_IN_AND_OUT
{
    >$OUTFILE

    exec 3<&0
    exec 0<$INFILE

    exec 4<&1
    exec 1>$OUTFILE

    while read
    do
        line 

    done 

    exec 1<&4
    exec 4>&-

    exec 0<&3
    exec 3>&-
}


#方法20
function while_LINE_line_FD_IN
{
    >$OUTFILE

    exec 3<&0
    exec 0<$INFILE


    while LINE=`line` 
    do
        echo "$LINE" >> $OUTFILE
    done 


    exec 0<&3
    exec 3>&-
}



#方法21
function while_LINE_line_cmdsub2_FD_IN
{
    >$OUTFILE

    exec 3<&0
    exec 0<$INFILE


    while LINE=$(line)

    do
        echo "$LINE" >> $OUTFILE
    done 


    exec 0<&3
    exec 3>&-
}

#方法22
function while_read_LINE_FD_IN_AND_OUT
{
    #最快的方法
    >$OUTFILE

    exec 3<&0
    exec 0<$INFILE

    exec 4<&1
    exec 1>$OUTFILE

    while read LINE
    do
        echo "$LINE"
    done

    exec 1<&4
    exec 4>&-

    exec 0<&3
    exec 3>&-
}

#方法23
function while_LINE_line_FD_IN_AND_OUT
{
    >$OUTFILE

    exec 3<&0
    exec 0<$INFILE

    exec 4<&1
    exec 1>$OUTFILE

    while LINE=`line`
    do
        echo "$LINE"
    done

    exec 1<&4
    exec 4>&-

    exec 0<&3
    exec 3>&-
}


#方法24
function while_LINE_line_cmdsub2__FD_IN_AND_OUT
{
    >$OUTFILE

    exec 3<&0
    exec 0<$INFILE

    exec 4<&1
    exec 1>$OUTFILE

    while LINE=$(line)
    do
        echo "$LINE"
    done

    exec 1<&4
    exec 4>&-

    exec 0<&3
    exec 3>&-
}
