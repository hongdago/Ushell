#!/bin/bash
#进度指示器：执行时间
elapsed_time()
{
    SEC=$1

    (($SEC < 60 )) && echo -e "[Elapsed time: $SEC seconds]\c"

    (($SEC >=60 && SEC <3600)) && echo -e "[Elapsed time : $((SEC / 60)) min $((SEC % 60)) seconds]\c"

    (($SEC >=3600 )) && echo -e "[Elapsed time : $((SEC / 3600)) hr  $(( (SEC % 3600) /60 )) min $(( (SEC % 3600) % 60 ))seconds]\c"

}

SECONDS=15
elapsed_time $SECONDS
echo
SECONDS=60
elapsed_time $SECONDS
echo
SECONDS=3844
elapsed_time $SECONDS
echo
