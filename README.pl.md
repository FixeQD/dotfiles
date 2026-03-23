<div align="center">

**Hyprland rice | Catppuccin Mocha**

_Arch Linux · Hyprland 0.54 · Wayland_

</div>

---

## Stack

| Rola          | Program          |
| ------------- | ---------------- |
| Compositor    | Hyprland         |
| Bar           | Waybar           |
| Powiadomienia | SwayNC           |
| Launcher      | anyrun           |
| Tapeta        | swww             |
| Ekran blokady | hyprlock         |
| Idle          | hypridle         |
| Terminal      | Ghostty          |
| Prompt        | Starship         |
| Fetch         | fastfetch        |
| Screenshot    | hyprshot         |
| Schowek       | cliphist         |
| Polkit        | polkit-kde-agent |
| Filtr nocny   | hyprsunset       |

---

## Co jest w środku

- Floating pill waybar z ikonami aplikacji w workspacach
- SwayNC z suwakami głośności/jasności, MPRIS, szybkie toggle
- Automatyczna zmiana tapety co 15 minut przez swww
- Ghostty z blur przez Hyprland (opacity override)
- Rofi z własnym ciemnym motywem — menadżer WiFi, schowek, power menu, emoji
- Skrypt nogaps — usuwa odstępy/border gdy tylko jedno okno
- Scrollujący tytuł muzyki w waybarze
- hyprlock — podzielony zegar, tło ze screenshota, wskaźnik Caps Lock

---

## Zależności

```bash
sudo pacman -S hyprland waybar swaync swww hyprlock hypridle \
  ghostty rofi-wayland anyrun-git hyprshot grim slurp \
  cliphist wl-clipboard polkit-kde-agent hyprpolkitagent \
  hyprsunset xdg-desktop-portal-hyprland \
  playerctl pamixer brightnessctl blueman \
  fastfetch starship jq socat ttf-jetbrains-mono-nerd \
  noto-fonts-emoji papirus-icon-theme

yay -S hyprpicker
```

---

## Instalacja

```bash
git clone https://github.com/fixeq/dotfiles.git
cd dotfiles
bash install.sh
```

Skrypt robi backup twoich aktualnych configów do `~/.config-backup-DATA` przed nadpisaniem.

---

## Skróty klawiszowe

| Klawisz         | Akcja              |
| --------------- | ------------------ |
| `Super+Return`  | Terminal (Ghostty) |
| `Super+Space`   | Launcher (anyrun)  |
| `Super+Q`       | Zamknij okno       |
| `Super+H`       | Toggle dolny panel |
| `Super+N`       | Toggle SwayNC      |
| `Super+L`       | Ekran blokady      |
| `Super+X`       | Menu zasilania     |
| `Super+V`       | Historia schowka   |
| `Super+Shift+S` | Screenshot regionu |
| `Super+Shift+R` | Przeładuj config   |
| `Super+W`       | Menu WiFi          |

---

## Tapety

Wrzuć tapety do `~/Obrazy/wallpapers/`. swww losuje jedną przy starcie i zmienia co 15 minut.

---

## Struktura

```
.
├── hypr/
│   ├── hyprland.conf
│   ├── bind.conf
│   ├── hypridle.conf
│   ├── hyprlock.conf
│   └── scripts/
├── waybar/
├── swaync/
├── rofi/
│   └── scripts/
├── ghostty/
├── swww/
├── fastfetch/
├── eww/
├── gtk-3.0/
├── gtk-4.0/
├── starship.toml
└── install.sh
```

---

<div align="center">
<sub>Zbudowane na Arch. Motyw: Catppuccin Mocha.</sub>
</div>
