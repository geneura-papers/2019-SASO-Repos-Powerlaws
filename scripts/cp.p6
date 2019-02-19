#!/usr/bin/env perl6

use v6;

my @files = 'ejabberd_3-erl hrl yrl escript ex exs','tensorflow_2-py cc h',
           'mojo_2-pl pm PL','tty_2-rb','cask_5-el py','webpack_2-js','language-perl6fe_4-coffee p6',
           'tpot_5-py','scalatra_2-scala','Moose_2-pl pm xs t','django_8-py','docker_2-go',
           'fission_4-go py js','vue_2-js','Dancer2_2-pl pm t','rakudo_4-pm pm6 pl pl6 nqp';
my $prefix = "/home/jmerelo/Code/literaturame/data/software/lines_";

for @files -> $f {
    say "Copying $prefix$f.csv";
    copy( "$prefix$f.csv", "data/2017/lines_$f.csv".IO ) || die "Can't copy";
}
