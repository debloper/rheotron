#!/usr/bin/perl

open (MASS, 'sample.mass');
while (<MASS>) {
	chomp;
	print "$_\n";
}
close (MASS);
