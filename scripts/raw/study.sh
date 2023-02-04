read endtime

declare -i counter=1 ; 
declare -i killtimer=5;

programs=(firefox neverball vlc) #comment
until [[ $( date +%H:%M ) == $endtime ]]
do 
	date

	echo "Study slot till $endtime"
	echo "..."
	echo "${bold}Focus".
	counter=$((counter+1))
	sleep 2		
	clear
	
	for program in "${programs[@]}"
	do
		if pgrep -x $program > /dev/null
		then
			for killtimer in {5..1}
				do
					echo "${bold} $program will be terminated in.. $killtimer seconds."
					sleep 1
					clear
					killtimer=$((killtimer-1))
				done
			pkill $program
		fi
	done
		
done
