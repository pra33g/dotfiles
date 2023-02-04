#!/bin/bash
for i in `vnstat -d | grep -a [0-9]`;
do 
NUMBER=$(echo $i | grep -o '[5-9][0-9][0-9]');
echo $NUMBER;
done;



