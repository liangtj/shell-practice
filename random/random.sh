#!/bin/bash

count=11
(( count++ ))
echo $RANDOM
read -p "input ur name: " firstname lastname
echo $firstname $lastname