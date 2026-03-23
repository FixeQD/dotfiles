#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
CONFIG="$HOME/.config"
BACKUP="$HOME/.config-backup-$(date +%F-%H%M%S)"
COMMON="$DOTFILES/common"

DIRS=(hypr waybar swaync rofi ghostty swww fastfetch eww gtk-3.0 gtk-4.0)

usage() {
    echo "Usage: bash install.sh [pl|en]"
    echo ""
    echo "  pl  — Polish version"
    echo "  en  — English version"
    exit 0
}

pick_lang() {
    echo ""
    echo "dotfiles"
    echo "=============="
    echo ""
    echo "  [1] Polski (pl)"
    echo "  [2] English (en)"
    echo ""
    read -rp "Choose [1/2]: " choice
    case "$choice" in
        1|pl) LANG_DIR="pl" ;;
        2|en) LANG_DIR="en" ;;
        *) echo "Invalid."; exit 1 ;;
    esac
}

case "${1:-}" in
    pl) LANG_DIR="pl" ;;
    en) LANG_DIR="en" ;;
    -h|--help) usage ;;
    "") pick_lang ;;
    *) echo "Unknown: $1"; usage ;;
esac

SRC="$DOTFILES/$LANG_DIR"
[[ -d "$SRC" ]] || { echo "Error: $SRC not found"; exit 1; }

echo ""
echo "Installing: $LANG_DIR"
echo "Backup:     $BACKUP"
echo ""

mkdir -p "$BACKUP"

for dir in "${DIRS[@]}"; do
    [[ -d "$CONFIG/$dir" ]] && cp -r "$CONFIG/$dir" "$BACKUP/" 2>/dev/null || true
    mkdir -p "$CONFIG/$dir"

    [[ -d "$COMMON/$dir" ]] && cp -r "$COMMON/$dir/." "$CONFIG/$dir/"
    [[ -d "$SRC/$dir" ]]    && cp -r "$SRC/$dir/."    "$CONFIG/$dir/"

    echo "  ✓ $dir"
done

[[ -f "$CONFIG/starship.toml" ]] && cp "$CONFIG/starship.toml" "$BACKUP/" 2>/dev/null || true
[[ -f "$COMMON/starship.toml" ]] && cp "$COMMON/starship.toml" "$CONFIG/starship.toml"
[[ -f "$SRC/starship.toml" ]]    && cp "$SRC/starship.toml"    "$CONFIG/starship.toml"
echo "  ✓ starship.toml"

find "$CONFIG/hypr/scripts" -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
find "$CONFIG/swww"         -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
find "$CONFIG/rofi/scripts" -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
find "$CONFIG/waybar"       -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
find "$CONFIG/eww/scripts"  -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true

echo ""
echo "Done. Reload Hyprland:"
echo "  hyprctl reload && killall waybar swaync; waybar & swaync &"
