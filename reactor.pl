#!/usr/bin/perl
use Data::Dumper;

# Open the file
# Read the file content as strings
# Store the string for further processing
# Close the file
# TODO: read the filename from arguments
$MASS = "";
open (MASS, 'sample.mass');
while (<MASS>) {
	chomp;
	$MASS = $MASS.$_;
}
close (MASS);

# Get the property names in order
@prop[0] = $MASS =~ /(.+?){/m;
push(@prop, $MASS =~ /}(.+?){/gm);

# Get the rulesets for the properties in order
@rules = $MASS =~ /{(.+?)}/gm;

# Initialize variables
%hash = ();
$count = 0;

# Loop over the available property names
while ($count < scalar @prop) {
	for (split(";", @rules[$count])) {
		my @rule = split(":", $_);
		$hash{@rule[0]}{@prop[$count]} = @rule[1].";";
	}
	$count++;
}

# Probe the created Hash
print Dumper(\%hash);
