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

		# Strip off the leading/trailing whitespaces/tabs
		@rule[0] =~ s/^[\s\t]+|[\s\t]+$//g;
		@prop[$count] =~ s/^[\s\t]+|[\s\t]+$//g;
		@rule[1] =~ s/^[\s\t]+|[\s\t]+$//g;

		# Construct the stylesheet hash
		$hash{@rule[0]}{@prop[$count]} = @rule[1].";";
	}
	$count++;
}

# Initialize output
my $CSS = "";

# Prepare the CSS from the has constructed
for my $selector (keys %hash) {
	$CSS .= $selector . " {\n";
	for (keys $hash{$selector}) {
		$CSS .= "\t".$_ . ": " . $hash{$selector}{$_} . "\n";
	}
	$CSS .= "}\n";
}

# Probe output CSS
print $CSS;
