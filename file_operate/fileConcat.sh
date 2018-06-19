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
#  -o   ... output filename
#
# Info:
#    default output file named "concatDefault.txt"
#
#
############################################################################

Usage() {
    echo "Usage: $0 [options] file ..."
    echo -e "Concat all files into a file\n"
    echo "Options: "
    echo " -h ... help message"
    echo " -v ... get detailed message"
    echo " -o ... output filename"
}

verb=false
targetFile="./concatDefault.txt"
optCount=0

while getopts "hvo:" opt
do
    case $opt in
        h)  Usage
            # (( optCount++ ))
            exit 0
            ;;
        v)  verb=true
            (( optCount++ ))
            ;;
        o)  targetFile=$OPTARG
            (( optCount+=2 ))
            ;;
    esac
done
shift $optCount

for file in $@
do  
    if [ ! -f $file ] 
    then
        echo "the input file should be ordinary file\
        instead of dir or device file"
        exit 1
    fi

    `cat $file >> $targetFile`
    if [ $? -ne 0 ]
    then 
        echo "Error in cat $file and writing to \
        file $targetFile; check its permissions $targetFile"
        exit 1
    fi
    
    if [ $verb = true ]
    then 
        echo "$file finished!"
    fi
done

if [ $verb = true ]
then
    echo "finish concating all files into $targetFile"
fi







