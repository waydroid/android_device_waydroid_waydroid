#!/vendor/bin/sh


if [ ! -d /sys/class/net/wlan0 ]; then
	/system/bin/ifconfig eth0 down
	/system/bin/ip link set eth0 name wifi_eth
	/system/bin/ifconfig wifi_eth up
	/system/bin/ip link add link wifi_eth name wlan0 type virt_wifi
fi
