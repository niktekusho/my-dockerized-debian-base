#!/usr/bin/env bash

# every exit != 0 fails the script
set -e

echo -e "\n------------------ window manager startup ------------------"

# disable screensaver and power management
xset -dpms &
xset s noblank &
xset s off &

# /usr/bin/i3 --replace > $HOME/wm.log &
/usr/bin/i3 >~/i3log-$(date +'%F-%k-%M-%S') 2>&1
sleep 1
cat $HOME/wm.log
