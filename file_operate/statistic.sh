#!/bin/bash 
############################################################################
#
# Usage: ./fileConcat.sh [options] file ...
#
# Count the number of lines in a given list of files.
# Uses a for loop over all arguments.
#
# Options:
#  -h   ... help message
#  -v   ... get detailed message
#  -s   ... target string
#
# Info: 
#   allow target string with space arounded
#
############################################################################

Usage() {
    echo "Usage: $0 [options] file ..."
    echo -e "statistic the number of the string shown in target files\n"
    echo "Options: "
    echo " -h ... help message"
    echo " -v ... get detailed message"
    echo -e " -s ... target line\n"
    echo "Info: "
    echo " allow target string with space arounded"
}

verb=false
target=""
count=0

while getopts "hvs:" opt
do
    case $opt in
        h)  Usage
            # (( optCount++ ))
            exit 0
            ;;
        v)  verb=true
            (( optCount++ ))
            ;;
        s)  target=$OPTARG
            (( optCount+=2 ))
            ;;
    esac
done

if [ -z $target ]
then 
    echo "errors: no target string"
    exit
fi
shift $optCount

for file in $@
do 
    if [ ! -f $file ]
    then 
        echo "the input file should be ordinary file\
        instead of dir or device file"
    fi
    tmpCount=`cat $file | awk -v t=$target 'BEGIN{ num = 0 } \
                            { if(match($0, t)) num++; } END{ print num }'`
    if [ $verb = true ]
    then 
        echo "$tmpCount target row in $file"
    fi
    (( count += tmpCount))
done

echo "$# files in total, with $count line matched target string in total"