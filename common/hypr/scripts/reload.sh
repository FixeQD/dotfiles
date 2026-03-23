#!/bin/bash

killall waybar
waybar &

killall swaync
swaync &

hyprctl reload

if ! pgrep -x swww-daemon > /dev/null; then
    swww-daemon --format xrgb &
    sleep 0.3
fi

swww img ~/.config/hypr/walls/1.png --transition-type wipe --transition-duration 1.5
