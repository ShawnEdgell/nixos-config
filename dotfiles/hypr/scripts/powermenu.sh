#!/run/current-system/sw/bin/bash

options="  Shutdown\n  Reboot\n  Lock\n  Logout"  # Changed Logout to \uf08b

chosen=$(echo -e "$options" | wofi --dmenu -p "Power Menu")

case "$chosen" in
    *Shutdown*) systemctl poweroff ;;
    *Reboot*) systemctl reboot ;;
    *Lock*) swaylock ;;
    *Logout*) hyprctl dispatch exit ;;
esac
