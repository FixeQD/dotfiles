#!/bin/bash

WALLS_DIR="${WALLS_DIR:-$HOME/Pictures/wallpapers}"
INTERVAL="${1:-0}"        # 0 = jednorazowo, N = co N minut
TRANSITION="${2:-random}" # transition style
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

EXTENSIONS=("jpg" "jpeg" "png" "webp" "gif")

get_random_wall() {
    local walls=()
    for ext in "${EXTENSIONS[@]}"; do
        while IFS= read -r -d '' f; do
            walls+=("$f")
        done < <(find "$WALLS_DIR" -iname "*.${ext}" -print0 2>/dev/null)
    done

    if [[ ${#walls[@]} -eq 0 ]]; then
        echo "No wallpapers in: $WALLS_DIR"
        exit 1
    fi

    echo "${walls[$RANDOM % ${#walls[@]}]}"
}

set_random() {
    local wall
    wall=$(get_random_wall)
    bash "$SCRIPT_DIR/wallpaper.sh" "$wall" "$TRANSITION"
}

if [[ "$INTERVAL" -eq 0 ]]; then
    set_random
else
    echo "Starting wallpaper cycle every ${INTERVAL} min (Ctrl+C to stop)"
    while true; do
        set_random
        sleep $(( INTERVAL * 60 ))
    done
fi
