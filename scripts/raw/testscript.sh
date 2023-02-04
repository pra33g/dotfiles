sudo ifconfig wlan0 down
sudo rmmod -f iwlwifi 
sudo modprobe iwlwifi 11n_disable=1 
sudo ifconfig wlan0 up
