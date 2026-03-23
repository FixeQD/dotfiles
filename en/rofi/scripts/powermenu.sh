#!/bin/bash

options=(
    "  Shutdown"
    "  Restart"
    "  Sleep"
    "  Lock"
    "  Logout"
    "  Cancel"
)

chosen=$(printf '%s\n' "${options[@]}" | rofi -dmenu \
    -p "  Power" \
    -theme ~/.config/rofi/theme.rasi \
    -theme-str '
        window { width: 300px; }
        listview { lines: 6; }
    ' \
    -no-custom \
    -selected-row 3)

case "$chosen" in
    "  Shutdown")          shutdown -h now ;;
    "  Restart") reboot ;;
    "  Sleep")            systemctl suspend ;;
    "  Lock")         hyprlock ;;
    "  Logout")          hyprctl dispatch exit ;;
esac
