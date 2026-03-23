#!/bin/bash

THEME="$HOME/.config/rofi/theme.rasi"
THEME_EXTRA='window { width: 500px; } listview { lines: 8; }'

active=$(nmcli -t -f NAME,DEVICE con show --active | grep -v "lo\|docker\|veth\|virbr" | head -1 | cut -d: -f1)

networks=$(nmcli -t -f SSID,SIGNAL,SECURITY dev wifi list 2>/dev/null | \
    grep -v "^--\|^$" | \
    awk -F: '{
        ssid=$1; signal=$2; sec=$3
        if (ssid == "") next
        icon = (signal+0 > 75) ? "󰤨" : (signal+0 > 50) ? "󰤥" : (signal+0 > 25) ? "󰤢" : "󰤟"
        lock = (sec != "--" && sec != "") ? " 󰌾" : ""
        printf "%s  %s  %s%%%s\n", icon, ssid, signal, lock
    }' | sort -t'%' -k1 -rn | head -20)

header="󰤨  Active: ${active:-none}"
extra="─────────────────
  󰤫  Shutdown WiFi
  󰒍  Refresh
─────────────────"

chosen=$(printf '%s\n%s\n%s' "$header" "$extra" "$networks" | rofi -dmenu \
    -p "󰤨  WiFi" \
    -theme "$THEME" \
    -theme-str "$THEME_EXTRA" \
    -no-custom)

[[ -z "$chosen" ]] && exit 0

case "$chosen" in
    *"Disable WiFi"*)
        nmcli radio wifi off
        notify-send "WiFi" "Disabled" -t 2000
        ;;
    *"Refresh"*)
        nmcli dev wifi rescan 2>/dev/null
        bash "$0"
        ;;
    *"Active:"*) ;;
    *"─"*) ;;
    *)
        ssid=$(echo "$chosen" | sed 's/^[^ ]* *//' | awk '{print $1}')
        [[ -z "$ssid" ]] && exit 0

        if nmcli con up "$ssid" 2>/dev/null; then
            notify-send "WiFi" "Connected to $ssid" -t 2000
        else
            pass=$(rofi -dmenu -p "  Password for $ssid" \
                -theme "$THEME" \
                -theme-str 'window { width: 400px; } listview { lines: 0; }' \
                -password)
            [[ -z "$pass" ]] && exit 0
            if nmcli dev wifi connect "$ssid" password "$pass" 2>/dev/null; then
                notify-send "WiFi" "Connected to $ssid" -t 2000
            else
                notify-send "WiFi" "Connection error for $ssid" -t 3000 -u critical
            fi
        fi
        ;;
esac
