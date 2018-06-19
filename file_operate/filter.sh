#!/bin/bash
############################################################################
#
# Usage: ./filter.sh [options] file ...
#
# 
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
    echo -e "filter string in files\n"
    echo "Options: "
    echo " -h ... help message"
    echo " -v ... get detailed message"
    echo -e " -s ... target string\n"
}

str=""
verb=false
while getopts "hvs:" opt
do
    case $opt in
        h)  Usage
            exit 0
            ;;
        v)  verb=true
            (( optCount++ ))
            ;;
        s)  str=$OPTARG
            (( optCount += 2 ))
            ;;
    esac
done
shift $optCount

for file in $@
do
    `sed -i "s/$str//g" $file `
    # if [ $? -ne 0 ] 
    # then 
    #     echo "error: cat & sed wrong"
    # fi

    if [ $verb = true ]
    then
        echo "$file done"
    fi
done

if [ $verb = true ]
then
    echo "filter finish" 
fi


