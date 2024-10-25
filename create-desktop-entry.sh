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

# 6. mv appimage to appropriate folder
mv "$file_path" "/bin/$file_name.AppImage"

# 7. Create desktop entry
touch "/usr/share/applications/$file_name.desktop"

# 8. Add desktop entry to desktop entry file
echo "[Desktop Entry]
Name=$file_name
Exec="/bin/$file_name.AppImage"
Icon=$(find "/opt/$file_name" -name "*.png" -o -name "*.svg" -print -quit)
Terminal=false
Type=Application
Categories=Utility;" >> "/usr/share/applications/$file_name.desktop"

# 9. Make desktop entry executable
chmod u+x "/usr/share/applications/$file_name.desktop"

# 10. Update desktop database
update-desktop-database /usr/share/applications
