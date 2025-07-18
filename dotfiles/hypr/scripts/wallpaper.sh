#!/usr/bin/env bash

# --- CONFIGURATION ---
WALLPAPER_DIR="/home/shawn/Pictures/Wallpapers/"
HYPRPAPER_CONF="/home/shawn/.config/hypr/hyprpaper.conf"

# --- SCRIPT LOGIC ---

# Ensure the wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
  echo "Error: Wallpaper directory '$WALLPAPER_DIR' not found."
  exit 1
fi

# Get a sorted list of all image files in the directory
mapfile -d '' WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \) -print0 | sort -z)

# Check if there are any wallpapers
if [ ${#WALLPAPERS[@]} -eq 0 ]; then
  echo "Error: No wallpapers found in '$WALLPAPER_DIR'."
  exit 1
fi

# Find the current wallpaper from hyprpaper.conf
CURRENT_WALLPAPER_PATH=$(grep -oP 'wallpaper\s*=\s*,(.*)' "$HYPRPAPER_CONF" | sed 's/wallpaper\s*=\s*,//' | xargs)

# Find the index of the current wallpaper in our array
CURRENT_INDEX=-1
for i in "${!WALLPAPERS[@]}"; do
   if [[ "${WALLPAPERS[$i]}" == "$CURRENT_WALLPAPER_PATH" ]]; then
       CURRENT_INDEX=$i
       break
   fi
done

# If the current wallpaper isn't found in the directory, start from the first one
if [ "$CURRENT_INDEX" -eq -1 ]; then
  NEXT_INDEX=0
else
  # Calculate the next index, wrapping around
  NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#WALLPAPERS[@]} ))
fi

# Get the full path of the next wallpaper
NEXT_WALLPAPER="${WALLPAPERS[$NEXT_INDEX]}"

# Update hyprpaper.conf with the new wallpaper
sed -i -e "s|^preload = .*|preload = $NEXT_WALLPAPER|" \
       -e "s|^wallpaper = .*|wallpaper = ,$NEXT_WALLPAPER|" \
       "$HYPRPAPER_CONF"

# Apply the new wallpaper using hyprctl
hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$NEXT_WALLPAPER"
hyprctl hyprpaper wallpaper ",""$NEXT_WALLPAPER"""
