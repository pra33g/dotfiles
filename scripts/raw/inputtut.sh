#!/bin/bash
NAME=${1?Error: no name}
NAME2=${2:-friend}
echo  hello $NAME and $NAME2
#also
read NAME3
echo hello to you too $NAME3
