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


&Setup();

sub Setup {


 my %catagory = (
            "1" => "Goals",
            "2" => "Valid"
        );


my @keysin = keys %catagory;
        my @sorted = sort { $a <=> $b } @keysin;

        foreach my $key (@sorted) {
            my $value = $catagory{$key};
            print "$key: $value\n";
        }

        my $answer = "";
        print "enter your # answer--->: ";
        chomp( $answer = <STDIN> );

	if ($answer eq 1) {

		#load goals menu
		&GoalsX();


	} elsif ($answer eq 2) {

		# prompt for validate data
		&Valid();

}


}




sub GoalsX {

my %goals = (

	"1" => "Gratitude",
	"2" => "Power",
	"3" => "Cosmic Humor",
	"4" => "Action Sparks",
	"5" => "Support"
);






my @keysin = keys %goals;
        my @sorted = sort { $a <=> $b } @keysin;

        foreach my $key (@sorted) {
            my $value = $goals{$key};
            print "$key: $value\n";
        }



        my $answer = "";
        print "enter your # answer--->: ";
        chomp( $answer = <STDIN> );

	my $data1 = $goals{$answer};

	&print_goal_data($data1);

&Setup();


}




sub print_goal_data {
    my $goal = shift;
    my $sth = $dbh->prepare("SELECT * FROM Build WHERE goal LIKE ? ORDER BY RAND() LIMIT 1");
    $sth->execute("%$goal%");
    while (my @row = $sth->fetchrow_array()) {
        print "Goal: $row[1]\n";
        print "Pattern: $row[2]\n";
        print "Validate: $row[3]\n\n";
    }
}


sub Valid {

# add what thought needs to feel valid.
# add what feeling needs to feel valid.
# add what experience needs to feel valid.

my @questions = ("Todays Effort", "Inner Truth", "Shadow Check", "Validation", "Idea", "Emotion", "Experience");
my @prompt = ("Did I truly do my best?", "What is still true about me?", "Where did i fall short?", "Am I Still valid even despite that?", "What idea needs validation?", "What emotion needs validation?", "What experience needs validation?");


my @answers = ();
my @setprompt = ();
my @aspect = ();



foreach my $item (@questions) {

		print "$item\n";

		my $datapoint = shift(@prompt);

		print "$datapoint\n";

        my $answer = "";
        print "enter your # answer--->: ";
        chomp( $answer = <STDIN> );

		push @aspect, $item;

		push @setprompt, $datapoint;

		push @answers, $answer;

		#print "$answer\n";


}




foreach my $data (@aspect) {

	my $a = shift(@setprompt);
	my $b = shift(@answers);


	&upload($data, $a, $b);

	print "Data: $data\tPrompt: $a\tAnswer: $b\n";



}




}


sub upload {

        my $aspect = shift;
        my $prompt = shift;
        my $outcome = shift;

		my $date = time;
        
my $sth = $dbh->prepare("INSERT INTO Valid ( `aspect`, `prompt`, `outcome`, `date`) VALUES (?,?,?,?)");
$sth->execute($aspect, $prompt, $outcome, $date);

}




