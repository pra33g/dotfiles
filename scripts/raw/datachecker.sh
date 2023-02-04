#/bin/bash
if [[ $(( $(vnstat -d --oneline|cut -d';' -f6|cut -d. -f1|paste -sd '+') )) -ge 500 ]];then
  echo 500 Mb reached
fi #xx
