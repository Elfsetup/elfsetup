
Linstaller
=================================

A Simple Fast Standalone Installer for Elementary OS.
-----------------------------------------------------

Linstaller can create a standalone distribution file
for Elementary OS for all binary executables and your
config and database files.

At moment, executable with dependecies other that build-in
in Elementary OS are not available.

But you can install all executable and your files with:
A Vala Executable (based in Gobject, Glib, Gtk2 or Gtk3, Gstreamer, etc)
A AppImage Executable (Simplify the Install and Uninstall Process if you like installed)
A Static Executable and all files needed by Executable.


At glance, try a test!:
---------------------------
Download the demo installer MyApp-v1.0
set
$ chmod +x ./MyApp-v1.0
and run.


Create a Installer for Elementary OS Applications in 3 steps.
---------------------------------------------------------------

Download or make a copy from original folder.

Original Folder has the following.
- (dir) content     [Here go the executable and content to be installed]
- (dir) payload     [the installer itself that will be in /tmp at setup time]
- builder           [the compiler for the install]
- decompresser      [a script for decompress the distribution]
- gpl.txt           [license]
- MyApp-v1.0        [a demo for didactical purposes]
- README.md         [this file]









Setup of github at local directory
=========================================

git init
git add *
git commit -m "first commit"
git remote add origin https://github.com/Nixsetup/nixsetup.git
git push -u origin master




(c) 2017 Marcelo G. Nuñez. <marcelognunez@gmail.com>. GNU General Public License v2.0
See license.txt at root directory

