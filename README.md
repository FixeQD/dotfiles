<div align="center">

**Hyprland rice | Catppuccin Mocha**

_Arch Linux · Hyprland 0.54 · Wayland_

</div>

---

## Install

```bash
git clone https://github.com/fixeq/dotfiles.git
cd dotfiles

bash install.sh       # interactive language picker
bash install.sh pl    # Polish
bash install.sh en    # English
```

Backs up existing configs to `~/.config-backup-DATE` before overwriting.

---

## Stack

| Role          | Program          |
| ------------- | ---------------- |
| Compositor    | Hyprland         |
| Bar           | Waybar           |
| Notifications | SwayNC           |
| Launcher      | anyrun           |
| Wallpaper     | awww             |
| Lockscreen    | hyprlock         |
| Idle          | hypridle         |
| Terminal      | Ghostty          |
| Shell prompt  | Starship         |
| Fetch         | fastfetch        |
| Screenshot    | hyprshot         |
| Clipboard     | cliphist         |
| Polkit        | polkit-kde-agent |
| Night light   | hyprsunset       |

---

## Dependencies

```bash
sudo pacman -S hyprland waybar swaync awww hyprlock hypridle \
  ghostty rofi-wayland grim slurp \
  cliphist wl-clipboard polkit-kde-agent \
  hyprsunset xdg-desktop-portal-hyprland \
  playerctl pamixer brightnessctl blueman \
  fastfetch starship jq socat ttf-jetbrains-mono-nerd \
  noto-fonts-emoji papirus-icon-theme polkit-kde-agent \
  kwallet kdeconnect

yay -S anyrun-git hyprshot hyprpicker
```

---

## Features

- Floating pill waybar with workspace app icons
- SwayNC with volume/backlight sliders, MPRIS, quick toggles
- Wallpaper auto-change every 15 minutes via awww
- Ghostty with Hyprland blur (opacity override)
- Rofi — wifi manager, clipboard, powermenu, emoji picker
- nogaps — removes gaps/borders when only one window is open
- Scrolling music title in waybar
- hyprlock — split clock, screenshot background, caps lock indicator

---

## Keybinds

| Key             | Action              |
| --------------- | ------------------- |
| `Super+Return`  | Terminal (Ghostty)  |
| `Super+Space`   | Launcher (anyrun)   |
| `Super+Q`       | Close window        |
| `Super+H`       | Toggle bottom panel |
| `Super+N`       | SwayNC toggle       |
| `Super+L`       | Lock screen         |
| `Super+X`       | Power menu          |
| `Super+V`       | Clipboard history   |
| `Super+Shift+S` | Region screenshot   |
| `Super+Shift+R` | Reload config       |
| `Super+W`       | WiFi menu           |

---

## Wallpapers

Put wallpapers in `~/Pictures/wallpapers/` (EN) or `~/Obrazy/wallpapers/` (PL).
awww picks a random one on startup and rotates every 15 minutes.

---

## Structure

```
.
├── pl/                 ← Polish version
│   ├── hypr/
│   ├── waybar/
│   ├── swaync/
│   ├── rofi/
│   ├── ghostty/
│   ├── awww/
│   ├── fastfetch/
│   ├── eww/
│   ├── gtk-3.0/
│   ├── gtk-4.0/
│   └── starship.toml
├── en/                 ← English version
│   └── ...
├── install.sh
└── README.md
```

---

<div align="center">
<sub>Built on Arch. Theme: Catppuccin Mocha.</sub>
</div>
