#!/usr/bin/perl

# Read the arguments for input filename
# Else set default to "sample.mass"
if (scalar @ARGV > 0) {
	$FILE = @ARGV[0];
} else {
	$FILE = "sample.mass";
}

# Initialize FileHandle
$MASS = "";

# Open the file to read
open (MASS, $FILE);

# Store the string for further processing
while (<MASS>) {
	chomp;
	$MASS = $MASS.$_;
}

# Close the file
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

# Read the arguments for output filename
# Else set default to "sample.css"
if (scalar @ARGV > 1) {
	$PUTS = @ARGV[1];
} else {
	$PUTS = "sample.css";
}

# Generate output to CSS file
open (CSS, ">", $PUTS);
print CSS $CSS;
close (CSS);
