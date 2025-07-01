#!/usr/bin/perl -w
## Mon Nov 19 18:22:08 PST 2012
## Christopher ctopher@me.com

use strict;
use DBI;
# use CGI;


my $dsn = "DBI:mysql:host=localhost;database=masterbox";
my $dbh = DBI->connect ($dsn, "root", "__PASSWORD__")
         or die "can not connect to server.\n";

 my $drop1 = $dbh->prepare("TRUNCATE Build");
$drop1->execute();


my $file = "uplift.tab.new";


my $time = time;



my @handles = ();
my $ip	= "127.0.0.1";


open (FI, $file) || die "sorry davey, no can do that way $file $!";
while (<FI>) {
	chomp;
	my ($goal, $pattern, $validate) = split(/\t/, $_);
	#my $line = $_;
	#	push @handles, $line;


	&upload($goal, $pattern, $validate);
}



sub upload {

	my $goal = shift;
	my $pattern = shift;
	my $validate = shift;
	
my $sth = $dbh->prepare("INSERT INTO Build ( `goal`, `pattern`, `validate`) VALUES (?,?,?)");
$sth->execute($goal, $pattern, $validate);

}



print "Good job!!!!\n";






