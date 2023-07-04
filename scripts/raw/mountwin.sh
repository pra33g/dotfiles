#!/bin/bash
part=`lsblk --list | grep '160.1G  0 part' | awk '{ print $1 }'`
echo $part
sudo mount /dev/$part ~/windows_160
