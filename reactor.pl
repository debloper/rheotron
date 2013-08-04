#!/usr/bin/perl

# Open the file
# Read the file content as strings
# Store the string for further processing
# Close the file
# TODO: read the filename from arguments
$MASS = "";
open (MASS, 'sample.mass');
local $/;
$MASS = <MASS>;
close (MASS);

# Get the property names in order
@prop = $MASS =~ /\n(.+){/gm;
print join(", ", @prop);

print "\n\n";

# Get the rulesets for the properties in order
@rules = $MASS =~ /{\n(.+?)\n}/gsm;
print join("\n==========\n", @rules)."\n";
