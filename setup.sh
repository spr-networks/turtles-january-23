#!/bin/bash

#After the containers are up, run this script to set up radios and set them up

move_iface_pid() {
  PID=$(docker inspect --format='{{.State.Pid}}' $2)
  PHY=phy$(iw $1 info | grep wiphy | awk '{print $2}')
  #echo move $1 is $PHY to $2 is $PID
  iw phy $PHY set netns $PID
}

set_iface_radio_group() {
  PHY=phy$(iw $1 info | grep wiphy | awk '{print $2}')
  echo $2 > /sys/kernel/debug/ieee80211/$PHY/hwsim/group
}

modprobe -r mac80211_hwsim
modprobe mac80211_hwsim radios=8

ATTACKER_PID=$(docker inspect --format='{{.State.Pid}}' t1_start)
ip link set hwsim0 netns $ATTACKER_PID

set_iface_radio_group wlan0 2
set_iface_radio_group wlan1 2
set_iface_radio_group wlan2 2
set_iface_radio_group wlan3 2

move_iface_pid "wlan0" "t1_ap"
move_iface_pid "wlan1" "t1_sta2"
move_iface_pid "wlan2" "t1_start"
move_iface_pid "wlan3" "t1_start"

set_iface_radio_group wlan4 4
set_iface_radio_group wlan5 4
set_iface_radio_group wlan6 4
set_iface_radio_group wlan7 4

move_iface_pid "wlan4" "t1_sta2"
move_iface_pid "wlan5" "t2_ap"
move_iface_pid "wlan6" "t2_sta2"
move_iface_pid "wlan7" "t2_sta2"

echo run execs now
docker exec -d t1_sta2 /go.sh
docker exec -d t1_start /go.sh
docker exec -d t1_ap /go.sh

docker exec -d t2_ap /go.sh
docker exec -d t2_sta2 /go.sh
