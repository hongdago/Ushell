#!/bin/bash
#Script:random_file.sh
#PURPOSE:This script is used to create a specific size file of random characters

WORKDIR=`pwd`
declare -i MB_SIZE=$1
declare -i RN
declare -i i=1
declare -i X=0
OUTFILE=largefile.random.txt
>$OUTFILE
THIS_SCRIPT=$(basename $0)
CHAR_FILE=${WORKDIR}/char_file.txt

build_random_line(){
    C=1
    LINE=
    until((C>79))
    do
        LINE="${LINE}${KEYS[$(($RANDOM % X + 1))]}"
        (( C = C + 1))
    done
    #return  the line of random characters
    echo $LINE
}

elasped_time(){
    SEC=$1
    (( SEC < 60)) && echo -e "Elasped time:\
        $SEC seconds]\c"

    (( SEC >=60 && SEC <=3600 )) && echo -e \
        "[Elasped time : $((SEC / 60)) min $((SEC % 60)) sec]\c"

    (( SEC > 3600 )) && echo -e "[Elasped time:\
        $((SEC / 3600)) hr $(( (SEC % 3600) / 60)) min \
        $(( (SEC % 3600) % 60 )) sec]\c" 
}

load_default_keyboard(){
    for CHAR in 1 2 3 4 5 6 7 8 9 0 q w e r t y u i o p a s d f g h j k l z x c v b n m Q W E R T Y U I O P A S D F G H J K L Z X C V B N M 0 1 2 3 4 5 6 7 8 9
    do
        echo  "$CHAR" >> $CHAR_FILE
    done
}


usage(){
    echo -e "\nUSAGE: $THIS_SCRIPT Mb_size"
    echo -e "Where Mb_size file is the size of the file to build\n"

}

if (($# != 1))
then
    usage
    exit 1
fi

#Test for an integer valuje
case $MB_SIZE in
    [0-9]) :
        ;;
    *):
        usage
        ;;
esac


if [ ! -s "$CHAR_FILE" ]
then
    echo -e "\n NOTE: $CHAR_FILE does not exist"
    echo "Loading default keyboard data ."
    echo -e "Create $CHAR_FILE...\c"
    load_default_keyboard
    echo "Done!"
fi

#Load Character Array
echo -e "\nLoading array with alphanumberic character elements"

while read ARRAY_ELEMENT
do
    (( X = X + 1))
    KEYS[$X]=$ARRAY_ELEMENT
done < $CHAR_FILE
echo "Total Array CHaracter Elements:$X"

#Use /dev/random to seed the shell variable RANDOM
echo "Querying the kernel random number generator for a random seed"
RN=$(dd if=/dev/random count=1 2>/dev/null \
    od -t u4 | awk '{print $2}' | head -n 1 )

echo "Reducing the random seed value to between 1 and 32767"

RN=$((RN % 32767 + 1))
echo "Assigning a new seed to the RANDOM shell variable"
RANDOM=$RN

echo "Building a $MB_SIZE MB random character file ==> $OUTFILE"
echo "Please be patient this may take some time to complete..."
echo -e "Executin:.\c"

START_TIME=`date +%s`
TOT_LINES=$((MB_SIZE * 12800))

until ((i>TOT_LINES))
do
    build_random_line >> $OUTFILE
    (($((i%100))==0)) && echo -e ".\c"
    (( i = i +1 ))
done

END_TIME=`date +%s`
(( TOT_SEC = END_TIME - START_TIME ))
echo -e "\n\nSUCESS:$OUTFILE created at $MB_SIZE MB \n"
elasped_time $TOT_SEC

#calculate the bytes/second file creation rate
(( MB_SEC = ( MB_SIZE * 102400)  / TOT_SEC ))

echo -e "\n\nFile Creation Rate: %$MB_SEC bytes/secnond\n"
echo -e "File size:\n"
ls -l $OUTFILE
echo
