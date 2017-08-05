#!/usr/bin/perl -w

############################################################
# Setup - A Graphical Installer for Elementary OS
# (c) 2017 Marcelo G. Nuñez. marcelognunez@gmail.com
# GNU GENERAL PUBLIC LICENSE v2.0
############################################################

use strict;
use warnings;
use Glib qw/TRUE FALSE/;
use Gtk2 '-init';



#### Configuration Settings ####


# (REQUIRED) Name of the Application to Install
# The name which be showed in the Setup Install.
# WARNING: CANNOT CONTAINS SPACES!.
my $setup_application = "MyApp-v1.0";


# Destination Directory. Where all content will be installed.
# By default, destdir is $HOME/Applications
# At moment, root install is not supported.
# Option as user ($HOME/Applications/MyApp-v1.0)
my $setup_destdir = $ENV{'HOME'} . "/Applications/" . $setup_application;


# Setup Image
# An image is shown as presentation in Setup.
# Put that image in payload folder, see the build-in example.
# image is 300x200 pixels in PNG format.
my $setup_image = "installer-300x200.png";



# Launcher in Applications menu (myapp.desktop)

# Install launcher in eOS "Applications" Menu by default
# when true, Setup has this option checked by default
my $launcher_install = TRUE;


# (REQUIRED) The application to start in Launcher (myapp.desktop will be created)
# this application can be a Vala app (based in eOS build-in libs), a static app or an AppImage app.
# applications with deps are in development.
# AppImage is a self contained applications (no external libs) for Linux and others systems.
my $launcher_exec = "myapp";


# (REQUIRED) Icon for "Applications" menu launcher (part of myapp.desktop)
# Put the Application icon into content, and write here
# the name of the icon. Icon are preffered SVG and PNG upper 32px
# WARNING: CANNOT CONTAINS SPACES!.
my $launcher_icon = "myapp.svg";


# (REQUIRED) A commentary showed in Applications menu (part of myapp.desktop)
my $launcher_comments = "An application for do things that I like.";


# (REQUIRED) The Categories in which is showed in Applications menu (part of myapp.desktop)
my $launcher_categories = "Education;Programming;";


# System keywords (part of myapp.desktop)
my $launcher_keywords = "$setup_application;education;programming;";



# If you have knowledge of Perl and Gtk2
# you will find more deep information on code follows.

#### End of Settings ####









# Main Window

#set user interface
&UI;


# start main
Gtk2->main;

my $window;
my $image;
my $lbl_location;
my $entry_location;
my $check_launch;
my $btn_install;





sub UI
{
	# create the window
	$window = Gtk2::Window->new('toplevel');
	$window->signal_connect(delete_event => \&delete_event);
	$window->set_title("Installer");
	$window->set_border_width(5);
	# $window->resize(480, 360);
	$window->set_resizable(FALSE);
	#$window->set_icon_from_file("installer-128.svg");
	$window->set_default_icon_from_file("installer-128.svg");
	# $window->set_opacity(0.90);

	# Form
	my $label1 = Gtk2::Label->new("Welcome to " . $setup_application . " for Elementary OS");
	$label1->show;

	$image = Gtk2::Image->new_from_file($setup_image);
	$image->show;

	$lbl_location = Gtk2::Label->new("Install in the path:");
	$lbl_location->set_justify('left');
	$lbl_location->show;

	$entry_location = Gtk2::Entry->new();
	$entry_location->set_text($setup_destdir);
	$entry_location->show;

	# Launch Checkbutton
	$check_launch = Gtk2::CheckButton->new("Install Launcher in Applications");
	$check_launch->set_active($launcher_install);
	$check_launch->signal_connect(toggled => \&check_launch_event);
	$check_launch->show;

	# Control Buttons
	$btn_install = Gtk2::Button->new("Install");
	$btn_install->signal_connect(clicked => \&install);
	$btn_install->show;

	my $btn_cancel = Gtk2::Button->new("Cancel");
	$btn_cancel->signal_connect(clicked => \&delete_event);
	$btn_cancel->show;

	my $controls = Gtk2::HBox->new(FALSE, 0);
	$controls->pack_start($btn_install, TRUE, TRUE, 0);
	$controls->pack_start($btn_cancel, TRUE, TRUE, 0);
	$controls->show;


	# Pack all
	my $vboxes = Gtk2::VBox->new(FALSE, 5);
	$vboxes->add($label1);
	$vboxes->add($image);
	$vboxes->add($lbl_location);
	$vboxes->add($entry_location);
	$vboxes->add($check_launch);
	$vboxes->add($controls);
	$vboxes->show;

	# Put the box into the main window.
	$window->add($vboxes);

	$window->show;
}











# Events Handlers

sub callback
{
	my ($button, $data) = @_;
	print "Hello again - $data was pressed\n";
}



sub delete_event
{
	Gtk2->main_quit;
	return FALSE;
}



sub check_launch_event
{
	&uninstaller();
}





# Functions


sub install
{
	my $program = "";
	my $home = $ENV{'HOME'};
	my $location = $entry_location->get_text();

	unless(-e "$home/Applications") {
		mkdir("$home/Applications", 0775);
	}

	unless(-e "$home/bin") {
		mkdir("$home/bin", 0775);
	}

	# pkexec tar -xf ./content.tar -C $location
	unless(-e $location) {
		mkdir($location, 0775);
		$program = ("tar -xf ./content.tar -C $location");
		my $ret = system($program);
	}

	# Launcher must be installed?
	if( $check_launch->get_active() ) {
		print("Installing Applications Launcher...\n");
		&desktop_file();

		#exec("xdg-desktop-menu install --novendor ./$launcher_exec.desktop");

		# Desktop Launcher in local
		rename("./$launcher_exec.desktop", "$home/.local/share/applications/$launcher_exec.desktop");

		# Icon in local
		rename("$location/$launcher_icon", "$home/.local/share/icons/$launcher_icon");

		my $symlink_exists = eval { symlink("",""); 1 };
		if($symlink_exists) {
			my $k = link("$location/$launcher_exec", "$home/bin/$launcher_exec");
			print("Result $k = $home/bin/$launcher_exec" . " <- " . "$location/$launcher_exec" . "\n");
		}

		# $btn_install->set_label("Uninstall");
		&uninstaller();
		rename("./uninstaller.pl", "$location/uninstaller.pl");


		$window->hide_on_delete();
		&install_successful();
		&delete_event();
	}
}




sub uninstaller {
	my $home = $ENV{'HOME'};
	my $location = $entry_location->get_text();

	my $unwise = <<UNWISE;
#!/usr/bin/perl
use strict;
use warnings;
use Glib qw/TRUE FALSE/;
use Gtk2 '-init';

if(-e "$location") {
	system("rm -rf $location");
}

if(-e "$home/.local/share/applications/$launcher_exec.desktop") {
	unlink "$home/.local/share/applications/$launcher_exec.desktop";
}

if(-e "$home/.local/share/icons/$launcher_icon") {
	unlink "$home/.local/share/icons/$launcher_icon";
}

if(-e "$home/bin/$launcher_exec") {
	unlink "$home/bin/$launcher_exec";
}

my \$message = "The Application has been Uninstalled!.";
my \$dialog = Gtk2::MessageDialog->new(undef, 'modal', 'info', 'ok', \$message);
\$dialog->set_title("Installer");
\$dialog->run;
\$dialog->destroy;
Gtk2->main_quit;
return FALSE;

UNWISE

	print($unwise . "\n");

	open (WRITE,">uninstaller.pl");
		print WRITE $unwise;
	close(WRITE);

	chmod 0775, "uninstaller.pl";
}



sub desktop_file
{
	my $location = $entry_location->get_text();

	my $desktop = <<DESKTOP;
[Desktop Entry]
Name=$setup_application
GenericName=$setup_application
Comment=$launcher_comments
Categories=$launcher_categories
Exec="$location/$launcher_exec"
Icon=$launcher_icon
Terminal=false
Type=Application
X-GNOME-Gettext-Domain=$launcher_exec
Keywords=$launcher_keywords
Actions=Uninstall;

[Desktop Action Uninstall]
Name=Uninstall $setup_application
Exec="$location/uninstaller.pl"

DESKTOP

	print($desktop . "\n");

	open (WRITE,">$launcher_exec.desktop");
		print WRITE $desktop;
	close(WRITE);
}



sub root_check
{
	my $testpath = "/opt/sFFf3F3y4swThsrh4TGsg462";

	my @program = ("mkdir", $testpath);
	my $return = system(@program);

	print("checkroot: " . $return . "\n");

	if( -e $testpath) {
		print("take care, superuser privileges\n");
		@program = ("rmdir", $testpath);
		system(@program);
		return TRUE;
	} else {
		return FALSE;
	}
}



sub root_unavailable
{
	my $message = "Must start the application with root privileges. Open a command and exec: sudo ./setup.sh";
	my $dialog = Gtk2::MessageDialog->new(undef, 'modal', 'warning', 'ok', $message);
	$dialog->set_title("Installer");
	$dialog->run;
	$dialog->destroy;
}



sub install_successful
{
	my $home = $ENV{'HOME'};
	my $message = "$setup_application was installed successful, for Uninstall, Right click on Launcher Icon in Applications.";
	my $dialog = Gtk2::MessageDialog->new($window, 'modal', 'info', 'ok', $message);
	$dialog->set_title("Installer");
	$dialog->run;
	$dialog->destroy;
}


0;

