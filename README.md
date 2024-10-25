# Create Desktop Entry on Fedora

This guide outlines the steps for installing a new AppImage or other executable on Fedora and creating a desktop entry. A script is also included to automate the process for AppImages.

This is just my process, and what I have intially come up with my first time on linux/fedora. I'm sure there are better ways to do this or more preferred ways to do this and I encourage discussion and improvements.

## Creating a Desktop Entry on Fedora

1. Download the Application
   - For AppImages:
     - Download the AppImage file
     - Make it executable: `chmod u+x <package>`
   - For other formats (e.g., IntelliJ IDEA):
     - Download the tarball containing the application files

2. Move the Application to the Appropriate Path
   - AppImages: Move to `/bin`
   - Tarball folders: Extract to `/opt`

3. Create and Configure the Desktop Entry File
   - Create a `.desktop` file (ChatGPT can help with syntax)
   - Edit the Exec path:
     - For AppImages: `/bin/<package>`
     - For extracted applications: `/opt/<package>/bin/<package>`
   - Set the icon path:
     - For AppImages: Extract assets to `/opt/<package>`, then use `/opt/<package>/<package>.png`
     - For other formats: Locate the icon in the application folder
   - Add `%U` at the end of the Exec path
   - Make the `.desktop` file executable: `chmod u+x <package>.desktop`

4. Update the Desktop Database
   - Run: `update-desktop-database`

### Future Considerations

While this guide focuses on AppImages and tarballs, the general process can be applied to other application formats:
1. Move the executable to the appropriate path
2. Create a desktop entry
3. Update the desktop database
