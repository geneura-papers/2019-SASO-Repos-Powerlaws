#!/usr/bin/env perl

use strict;
use warnings;
use Text::Diff::Parser;

use v5.14;

my $file = "../diff-example-porcelain.txt";

my $parser = Text::Diff::Parser->new( File=>$file );
foreach my $change ( $parser->changes ) {
    say "File1: ", $change->filename1;
    say "Line1: ", $change->line1;
    say "File2: ", $change->filename2;
    say "Line2: ", $change->line2;
    say "Type: ", $change->type;
    my $size = $change->size;
    foreach my $line ( 0..($size-1) ) {
        say "Line: ", $change->text( $line );
    }
}
