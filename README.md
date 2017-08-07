

![picture alt](http://a.fsdn.com/con/app/proj/elfsetup/screenshots/screenshot-elfsetup.png "Elfsetup")

Elfsetup
=================================

A Simple Fast Standalone Installer for Elementary OS.
-----------------------------------------------------

Elfsetup can create a standalone distribution file
for Elementary OS for all binary executables and your
config and database files.

If not dependencies are required, you can install without a Internet connection.
Here a list of applications without aptitude requirement:
- A Vala Executable (based in Gobject, Glib, Gtk2 or Gtk3, Gstreamer, etc).
- A AppImage Executable (Simplify the Install and Uninstall Process if you like installed).
- A Static Executable and all files needed by Executable.
- A Tcl/Tk Application.
- A Perl/Gtk2 Application.
- A PyGTK Application.
- Etc.

Elfsetup can install packs. Packs are severals libraries downloaded from aptitude
in runtime that conform applications libraries dependencies.
(see "payload/setup.pl" for configuration)

- A Qt 4 Application. 
- A Java Jar Application. 
- An Executable with Libraries in Aptitude Repositories. 


At glance, try a test!:
---------------------------
Download the demo installer MyApp-v1.0
set
`$ chmod +x ./MyApp-v1.0`
and run.

Elfsetup installs in a MacOS X manner.
$HOME/Applications/

Commandline scope become ready in:
$HOME/bin via hard link.

You can install anywhere which have read-write-exec permissions..
At moment, others root folders (as /opt)
are not supported.


How uninstall??
----------------
As simple as, right click on launcher icon in "Applications" freedesktop menu or Wingpanel icon.
And select Uninstall MyApp-v1.0.

Examples?
----------
Look at https://sourceforge.net/projects/elfsetup/files/examples/
for examples with source code.
Elfsetup can install Java and Qt4 applications without dependencies headaches.


Create a Installer for Elementary OS Applications in 3 steps.
---------------------------------------------------------------

Download or make a copy from original folder.

git clone https://github.com/Elfsetup/elfsetup.git
or download a tarball from http://elfsetup.sourceforge.io/

Original Folder has the following.

| File or Folder	| Content |
| ---------------------	|:-------------:|
| (dir) content      	| Here go the executable and content to be installed |
| (dir) payload     	| the installer itself that will be in /tmp at setup time |
| builder	 	| the compiler for the install |
| decompresser		| a script for decompress the distribution] |
| MyApp-v1.0		| a demo for didactical purposes |
| README.md		| This file |



Personalize your installer in 3 simple steps
-----------------------------------------------
1) Put all binaries to be installed in the host system
in "content" folder. That include executables and folder for the executable
or config files and/or databases file used by executable.
Make sure to include a PNG or SVG file as Application Icon. (see Step 2)

2) open with your favorite text editor "payload/setup.pl", and fill
the REQUIRED variables with your application information.
Make sure to include a PNG or SVG file as Application Icon in "content" folder.

3) open a command line at root of the project and execute:
`$ ./builder`

You will get a "setup.sh", it is the self extractor installer.
Feel free to rename with your setup name of preference.

(Ex: `$ mv ./setup.sh ./MyApp-v1.0`)

Take care of the use of SPACES in some places for avoid errors.


More In-depth
-----------------------------------------------------

The files and folder in "content" directory are compressed
in the content.tar inside payload directory.
"payload" is the folder which be compressed at build time.
and joined with a special script in order to decompress
the "payload" content (payload.tar.gz) into /tmp, in the system host.

Once time the setup.sh selfextract script was created.
you can delete the payload.tar.gz, it is not used anymore.
"builder" do not delete it for debugger purposes.

the GUI application installer is the "payload/setup.pl"
these contain a first configuration file session, and
after, a Perl/Gtk2 applications. It can run without
any dependencies in Elementary OS.

"Payload" directory include a installer-128.svg, it is
a icon 128 x 128 pixels for installer when is running.
Also, installer-300x200.png is a presentation graphic
for the installer, you can preserve the size
and can be customized to your need.

"payload/setup.pl" create, in runtime, a "uninstaller.pl"
GtkPerl script in destination folder for Uninstall
purposes. This script is called in the generated *.desktop
file created for icon and launcher in "Applications".

If you are a developer, and want personalize more,
you can run "payload/setup.pl" from commmandline
and will get print's with debugger information.

More info on Gtk2/Perl:  
http://gtk2-perl.sourceforge.net/doc/gtk2-perl-tut/index.html  
http://gtk2-perl.sourceforge.net/doc/pod/index.html  


This describe in a graphical mood:  
setup.sh = decompresser + payload.tar.gz  
payload.tar.gz = "payload" folder (installer + content)  
content = exec and config files.  



Setup of github at local directory
------------------------------------
If you want develop from git here the cookbook:

|Git     |
|:-------|
|git init|
|git add *|
|git commit -m "first commit"|
|git remote add origin https://github.com/Elfsetup/elfsetup.git|
|git push -u origin master|





(c) 2017 Marcelo G. Nuñez. <marcelognunez@gmail.com>. GNU General Public License v2.0
See license.txt at root directory

