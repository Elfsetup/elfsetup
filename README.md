

![picture alt](http://a.fsdn.com/con/app/proj/nixsetup/screenshots/screenshot-nixsetup.png "Nixsetup")

Nixsetup
=================================

A Simple Fast Standalone Installer for Elementary OS.
-----------------------------------------------------

Nixsetup can create a standalone distribution file
for Elementary OS for all binary executables and your
config and database files.

At moment, executable with dependecies other that build-in
in Elementary OS are not available.

But you can install all executable and your files with:
- A Vala Executable (based in Gobject, Glib, Gtk2 or Gtk3, Gstreamer, etc).
- A AppImage Executable (Simplify the Install and Uninstall Process if you like installed).
- A Static Executable and all files needed by Executable.


At glance, try a test!:
---------------------------
Download the demo installer MyApp-v1.0
set
`$ chmod +x ./MyApp-v1.0`
and run.


Create a Installer for Elementary OS Applications in 3 steps.
---------------------------------------------------------------

Download or make a copy from original folder.

Original Folder has the following.

|			|               |
| ---------------------	|:-------------:|
| (dir) content      	| Here go the executable and content to be installed |
| (dir) payload     	| the installer itself that will be in /tmp at setup time |
| builder	 	| the compiler for the install |
| decompresser		| a script for decompress the distribution] |
| MyApp-v1.0		| a demo for didactical purposes |
| README.md		| This file |


|
Personalize your installer in 3 simple steps
-----------------------------------------------
1) Put all binaries to be installed in the host system
in "content" folder. That include executables and folder for the executable
or config files and/or databases file used by executable.

2) open with your favorite text editor "payload/setup.pl", and fill
the REQUIRED variables with your application information.

3) open a command line at root of the project and execute:
`$ ./builder`

You will get a "setup.sh", it is the self extractor installer.
Feel free to rename with your setup name of preference.
(Ex: `$ mv ./setup.sh ./MyApp-v1.0`)

Take care of the use of SPACES in some places for avoid errors.







Setup of github at local directory
=========================================

git init
git add *
git commit -m "first commit"
git remote add origin https://github.com/Nixsetup/nixsetup.git
git push -u origin master





(c) 2017 Marcelo G. Nuñez. <marcelognunez@gmail.com>. GNU General Public License v2.0
See license.txt at root directory

