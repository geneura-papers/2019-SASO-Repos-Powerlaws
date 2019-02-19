#!/usr/bin/env perl

use strict;
use warnings;
use Text::Diff::Parser;

use v5.14;

my $file = "../diff-example-porcelain.txt";

my $parser = Text::Diff::Parser->new( File=>$file );
foreach my $change ( $parser->changes ) {
    print "File1: ", $change->filename1;
    print "Line1: ", $change->line1;
    print "File2: ", $change->filename2;
    print "Line2: ", $change->line2;
    print "Type: ", $change->type;
    my $size = $change->size;
    foreach my $line ( 0..($size-1) ) {
        print "Line: ", $change->text( $line );
    }
}
