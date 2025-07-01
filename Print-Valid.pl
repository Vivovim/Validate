#!/usr/bin/perl -w
## Mon Jun 30 14:15:37 MST 2025
## Neo Ctopher neo@ctopher.me 


use strict;
use warnings;
use Time::Piece;
use DBI;



# Load menu. based on goal of outcome.
# Display value based on selection
# prompt for input on validation system.



# Connect to database
my $dsn = "DBI:mysql:host=localhost;database=masterbox";
my $dbh = DBI->connect ($dsn, "root", "__PASSWORD__")
         or die "can not connect to server.\n";





  my $sth = $dbh->prepare( "SELECT * FROM Valid ORDER BY recid"); 
                $sth->execute();
                while (my @row = $sth->fetchrow_array()) {
						print "Goal: $row[1]\n";
                        print "Pattern: $row[2]\n";
                        print "Validate: $row[3]\n\n";

				}





