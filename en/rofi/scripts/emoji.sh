#!/bin/bash

if command -v rofi-emoji &>/dev/null; then
    rofi -show emoji \
        -theme ~/.config/rofi/theme.rasi \
        -theme-str 'window { width: 500px; } listview { lines: 8; }'
    exit
fi

emojis=(
    "😀 Smile" "😂 Laugh" "🥹 Touched" "😎 Cool" "🤔 Thinking"
    "😭 Cry" "🔥 Fire" "💀 Skull" "👍 OK" "👎 No"
    "❤️ Heart" "💜 Purple" "⭐ Star" "✅ Check" "❌ Cross"
    "🎉 Party" "🚀 Rocket" "💻 Laptop" "🐧 Penguin" "🦀 Crab"
    "⚡ Lightning" "🌙 Moon" "☀️ Sun" "🌈 Rainbow" "🎵 Music"
)

chosen=$(printf '%s\n' "${emojis[@]}" | rofi -dmenu \
    -p "  Emoji" \
    -theme ~/.config/rofi/theme.rasi \
    -theme-str 'window { width: 400px; } listview { lines: 8; }')

[[ -z "$chosen" ]] && exit 0

echo "$chosen" | awk '{print $1}' | wl-copy
notify-send "Emoji copied" "$chosen" -t 1500
