#!/usr/bin/perl

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
@prop = $MASS =~ /}(.+?){/gm;

# Get the rulesets for the properties in order
@rules = $MASS =~ /{(.+?)}/gm;

# Initialize variables
my %hash = ();
my $count = 0;

# Loop over the available property names
while ($count < scalar @prop) {
	print @rules[$count]."\n";
	%hash->{@prop[$count]} = @rules[$count];
	$count++;
}

# Probe the created Hash
print join(",\n", %hash)."\n";
