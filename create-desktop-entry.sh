#! /bin/bash

# 1. Take file path as argument
file_path=$1

# 2. Extract the file name from the file path ignore .AppImage extension
file_name=$(basename "$file_path" .AppImage)

# 3. Make AppImage executable
chmod u+x "$file_path"

# 4. Get assets
"$file_path" --appimage-extract

#5. Rename and move assets to appropriate folder
if [ -d "/opt/$file_name" ]; then
    echo "Directory /opt/$file_name already exists. Removing it..."
    rm -rf "/opt/$file_name"
fi
mv "squashfs-root" "/opt/$file_name"

# 6. Create local bin directory if it doesn't exist
mkdir -p "$HOME/.local/bin"

# 7. mv appimage to appropriate folder
mv "$file_path" "$HOME/.local/bin/$file_name.AppImage"

# 8. Create local applications directory if it doesn't exist
mkdir -p "$HOME/.local/share/applications"

# 9. Create desktop entry
touch "$HOME/.local/share/applications/$file_name.desktop"

# 10. Add desktop entry to desktop entry file
echo "[Desktop Entry]
Name=$file_name
Exec=\"$HOME/.local/bin/$file_name.AppImage\"
Icon=$(find "/opt/$file_name" -name "*.png" -o -name "*.svg" -print -quit)
Terminal=false
Type=Application
Categories=Utility;" >> "$HOME/.local/share/applications/$file_name.desktop"

# 11. Make desktop entry executable
chmod u+x "$HOME/.local/share/applications/$file_name.desktop"

# 12. Update desktop database
update-desktop-database "$HOME/.local/share/applications"
