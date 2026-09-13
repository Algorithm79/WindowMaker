##!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
ROFI_THEME="$HOME/.config/rofi/wallpaper-picker.rasi"

if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Wallpaper Picker" "Folder $WALLPAPER_DIR not found."
    exit 1
fi

# Genererate list to Rofi
SELECTED=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort | while read -r img; do
    echo -en "$(basename "$img")\0icon\x1f${img}\n"
done | rofi -dmenu \
            -i \
            -p "🖼️ Wallpaper" \
            -theme "$ROFI_THEME" \
            -show-icons)

# Select image
if [ -n "$SELECTED" ]; then
    FULL_PATH="$WALLPAPER_DIR/$SELECTED"
    
    # Set the wallpaper (feh, swww, etc.)
    feh --bg-fill "$FULL_PATH"
    
    notify-send "Wallpaper Picker" "Wallpaper changed to: $SELECTED"
fi