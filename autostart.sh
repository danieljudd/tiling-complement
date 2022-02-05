#!/usr/bin/env bash

# This file may go here [ "$HOME/.dwm" ] or xinitrc
# Made by danieljudd.github.com

# Network management tray applet
# 	Use nm-tray in Debian if there is no nm-applet installed
exec nm-applet &

# Mount network drive
# sshfs (username@ip):/mnt/LANdrive /mnt/localdrive/

# Bluetooth tray
exec blueberry-tray &

#	| monitor standby | suspend | off
exec xset dpms 3600 4500 0 &

# screensaver off because interferes with watching fullscreen video
exec xset s off &

# allows java programs to run
# https://tools.suckless.org/x/wmname/
wmname LG3D &

# Set wallpaper (requires feh)
feh --bg-scale ~/Pictures/wallpaper.jpg &

# !! Update location here (and once below) !!
WEATHER=$(curl wttr.in/Cardiff?format="%l:+%m+%p+%w+%t+%c+%C")

while true; do
	LOCALTIME=$(date +'%A, %d-%m-%Y %H:%M')
        MEM=$(free -h --kilo | awk '/^Mem:/ {print $3 "/" $2}')
        CPU=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
        VOL=$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master))
        
        # LINUX=$(uname -r)
        # TOTALDOWN=$(sudo ifconfig wlan0 | grep "RX packets" | awk {'print $6 $7'})
        # TOTALUP=$(sudo ifconfig wlan0 | grep "TX packets" | awk {'print $6 $7'})
        
        # Enable if you have a battery (laptop) and add "🔋️ $BAT%" to xsetroot list
	# 	BAT=$(cat '/sys/class/power_supply/BAT0/capacity')
	
        # Check Weather every half hour
        # 	!! Update location here !!
        
        if [ $(date +'%M') == 30 ] || [ $(date +'%M') == 00 ]; then WEATHER=$(curl wttr.in/Cardiff?format="%l:+%m+%p+%w+%t+%c+%C"); fi
        xsetroot -name "⌚️ $LOCALTIME | 💾️ $MEM | ⚡️ $CPU | $WEATHER | 🎚️ $VOL"
        
        sleep 10s
done &
