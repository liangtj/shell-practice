#!/bin/bash 
############################################################################
#
# Usage: loc7.sh [options] file ...
#
# Count the number of lines in a given list of files.
# Uses a for loop over all arguments.
#
# Options:
#  -h     ... help message
#  -d n ... consider only files modified within the last n days
#  -w n ... consider only files modified within the last n weeks
#  -v   ...get detailed message
#
# Limitations: 
#  . only one option should be given; a second one overrides
#
############################################################################

simpleUsage() {
    echo "Usage: $0 [options] file ..."
}

detailedUsage() {
    # echo "Usage: "
    simpleUsage
    echo "Options:"
    echo -e " -h\t ...help message"
    echo -e " -d n\t ...consider only files modified within the last n days"
    echo -e " -w n\t ...consider only files modified within the last n weeks"

    echo "Limitations: "
    echo " only one option should be given; a second one overrides"
}

timeLen=0
timeUnit=("days" "week")
timeUnitIndex=0
optCount=0
verbose=false

while getopts "vhd:w:" opt
do
    case $opt in
    h)  detailedUsage
        (( optCount++ ))
        ;;
    v)  verbose=true
        (( optCount++ ))
        ;;
    d)  timeLen=$OPTARG
        timeUnitIndex=0
        # isday=true
        (( optCount+=2 ))
        ;;
    W)  timeLen=$OPTARG
        timeUnitIndex=1
        # isday=false
        (( optCount+=2 ))
        ;;
    # [?]) echo '????'
    esac
done

shift $optCount

lineSum=0
designatedTime=`date --date="$timeLen ${timeUnit[timeUnitIndex]} ago" +%y%m%d`
lineCount=0

if [ $verbose = true ]
then
    echo "$0 start"
fi

for file in $@
do
    fileLastModTime=`stat -c %y $file`
    stdfileLastModTime=`date --date="$fileLastModTime" +%y%m%d`
    if [ $stdfileLastModTime -ge $designatedTime ]
    then
        fileLineCount=`wc -l $file | sed 's/\([0-9]*\).*/\1/'`
        (( lineCount += $fileLineCount ))
        if [ $verbose = true ]
        then 
            echo "  $file: $fileLineCount lines in total"
        fi

    fi
done

echo "$# files in total, $lineCount in total"

    
    


