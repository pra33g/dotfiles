#! /bin/bash
i=0;
while [ true ];
 do
  sleep 0.9;
  printf '\r%02i:%02i' $(( i/60 )) $(( i % 60 ));
  i=$(( i+1 ));
  read -n 1 -s -t 0.1 inp
  if [[ ! -z $inp ]]; 
   then
    if [[ $inp == 'c' ]]; then #clear
     i=0;
    elif [[ $inp == 's' ]]; then #split time
     echo " ";
     i=0;
    elif [[ $inp == 'd' ]]; then #discard
     printf "\r    ";
     i=0;
    fi
  fi
 done;
