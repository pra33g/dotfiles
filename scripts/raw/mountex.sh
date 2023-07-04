#!/bin/bash
part=`lsblk --list | grep '931.5G  0 part' | awk '{ print $1 }'`
echo $part
sudo mount /dev/$part ~/external_931
