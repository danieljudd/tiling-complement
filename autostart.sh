#    Copyright (C) 2021  Daniel Judd, https://github.com/danieljudd
#    danieljudd.xyz
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

#!/usr/bin/env bash

# This file may go here [ "$HOME/.dwm" ]

# Network management tray applet
# 	Use nm-tray in Debian if there is no nm-applet installed
exec nm-applet &

# Mount network drive
# sshfs (username@ip):/mnt/LANdrive /mnt/localdrive/

# Bluetooth tray
exec blueberry-tray &

# monitor standby | suspend | off
exec xset dpms 3600 4500 0 &
# screensaver off
exec xset s off &

# allows java programs to run
# https://tools.suckless.org/x/wmname/
wmname LG3D &

feh --bg-scale ~/Pictures/wallpaper.jpg &

# !! Update location here (and once below) !!
WEATHER=$(curl wttr.in/Cardiff?format="%l:+%m+%p+%w+%t+%c+%C")

while true; do
	LOCALTIME=$(date +'%A, %d-%m-%Y %H:%M')
        MEM=$(free -h --kilo | awk '/^Mem:/ {print $3 "/" $2}')
        #LINUX=$(uname -r)
        #TOTALDOWN=$(sudo ifconfig wlan0 | grep "RX packets" | awk {'print $6 $7'})
        #TOTALUP=$(sudo ifconfig wlan0 | grep "TX packets" | awk {'print $6 $7'})
        CPU=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
        VOL=$(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master))
        BAT=$(cat /sys/class/power_supply/BAT0/capacity)
        # Check Weather every half hour
        # !! Update location here !!
        if [ $(date +'%M') == 30 ] || [ $(date +'%M') == 00 ]; then WEATHER=$(curl wttr.in/Cardiff?format="%l:+%m+%p+%w+%t+%c+%C"); fi
        xsetroot -name " $LOCALTIME | MEM: $MEM | CPU: $CPU | $WEATHER | VOL: $VOL | BAT: $BAT%"
        sleep 10s
done &
