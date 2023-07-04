#! /bin/bash
programs=(firefox-bin vlc) #comment
count=1

while [ 1 ]
do
	echo 'Monitoring...'
	for program in "${programs[@]}"
	do
		if pgrep -x $program > /dev/null
		then
			echo $program started - $count
		fi
	done
	count=$((count + 1))
done
