#!/bin/bash
rm *png
rm *jpeg
rm *jpg
for i in *; do
	echo $i
	if [[ -f $i ]]; then
		echo $(pwd)/$i > code.txt
		cat $i >> code.txt
		mousepad code.txt
		rm code.txt
	fi;
done;
