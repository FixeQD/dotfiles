#!/bin/bash

WALLS_DIR="$HOME/Pictures/wallpapers"
STATE_FILE="$HOME/.cache/swww/current_wallpaper"

transition_smooth() {
    swww img "$1" \
        --transition-type wipe \
        --transition-angle 30 \
        --transition-duration 1.5 \
        --transition-fps 60 \
        --transition-bezier .43,1.19,1,.4
}

transition_fade() {
    swww img "$1" \
        --transition-type fade \
        --transition-duration 1.2 \
        --transition-fps 60 \
        --transition-bezier .25,.46,.45,.94
}

transition_grow() {
    swww img "$1" \
        --transition-type grow \
        --transition-pos center \
        --transition-duration 1.0 \
        --transition-fps 60 \
        --transition-bezier .43,1.19,1,.4
}

transition_outer() {
    swww img "$1" \
        --transition-type outer \
        --transition-pos center \
        --transition-duration 1.2 \
        --transition-fps 60 \
        --transition-bezier .25,.46,.45,.94
}

transition_random() {
    local types=("wipe" "fade" "grow" "outer" "wave")
    local angles=(0 30 45 90 135)
    local t=${types[$RANDOM % ${#types[@]}]}
    local a=${angles[$RANDOM % ${#angles[@]}]}
    swww img "$1" \
        --transition-type "$t" \
        --transition-angle "$a" \
        --transition-duration 1.2 \
        --transition-fps 60 \
        --transition-bezier .25,.46,.45,.94
}

transition_instant() {
    swww img "$1" --transition-type none
}

set_wallpaper() {
    local image="$1"
    local style="${2:-smooth}"

    if [[ ! -f "$image" ]]; then
        echo "Error: plik nie istnieje: $image"
        exit 1
    fi

    if ! pgrep -x swww-daemon > /dev/null; then
        swww-daemon --format xrgb &
        sleep 0.5
    fi

    case "$style" in
        smooth)  transition_smooth  "$image" ;;
        fade)    transition_fade    "$image" ;;
        grow)    transition_grow    "$image" ;;
        outer)   transition_outer   "$image" ;;
        random)  transition_random  "$image" ;;
        instant) transition_instant "$image" ;;
        *)       transition_smooth  "$image" ;;
    esac

    mkdir -p "$(dirname "$STATE_FILE")"
    echo "$image" > "$STATE_FILE"

    echo "Wallpaper set: $image (styl: $style)"
}

if [[ $# -ge 1 ]]; then
    set_wallpaper "$1" "${2:-smooth}"
else
    echo "Usage: wallpaper.sh <path> [smooth|fade|grow|outer|random|instant]"
    exit 1
fi
