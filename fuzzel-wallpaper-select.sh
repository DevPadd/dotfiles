#!/bin/sh

# 1. Define the absolute path to your wallpapers directory
WALL_DIR="$HOME/Pictures/wallpapers"

# 2. Check if the directory actually exists
if [ ! -d "$WALL_DIR" ]; then
  echo "Directory $WALL_DIR does not exist."
  exit 1
fi

# 3. Find images, strip the folder path for clean listing, and launch rofi
chosen=$(find "$WALL_DIR" -maxdepth 1 -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" -o -name "*.gif" \) | sed "s|$WALL_DIR/||" | rofi -dmenu)

# 4. Pass the full path to waypaper if an image was selected
if [ -n "$chosen" ]; then
  waypaper --wallpaper "$WALL_DIR/$chosen"
  notify-send -a "Wallpaper Changer" -i "$WALL_DIR/$chosen" "Wallpaper Updated" "background set to: \n<b>$chosen</b>"
fi