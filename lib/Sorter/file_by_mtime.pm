package Sorter::file_by_mtime;

use 5.010001;
use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

sub meta {
    return +{
        v => 1,
        summary => 'Sort files by mtime (modification time)',
        args => {
            reverse => {schema => 'bool*'},
            ci => {schema => 'bool*'},
        },
    };
}

sub gen_sorter {
    my %args = @_;

    my $reverse = $args{reverse};

    sub {
        my @items = @_;
        my @mtimes = map { -M $_ } @items;

        map { $items[$_] } sort {
            $reverse ? $mtimes[$a] <=> $mtimes[$b] : $mtimes[$b] <=> $mtimes[$a]
        } 0 .. $#items;
    };
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|gen_sorter)$

=head1 SYNOPSIS

 use Sorter::file_by_mtime;

 my $sorter = Sorter::file_by_mtime::gen_sorter();
 my @sorted = $sorter->("newest", "old", "new");
 # => ("old", "new", "newest")

Reverse:

 $sorter = Sorter::file_by_mtime::gen_sorter(reverse=>1);
 @sorted = $sorter->("newest", "old", "new");
 # => ("newest", "new", "old")


=head1 DESCRIPTION

This sorter assumes items are filenames and sort them by modification time
(mtime).


=head1 SORTER ARGUMENTS

=head2 reverse

Bool.

=cut
