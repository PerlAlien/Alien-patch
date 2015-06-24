package Alien::patch;

use strict;
use warnings;
use base qw( Alien::Base );
use Env qw( @PATH );

# ABSTRACT: Find or build patch
# VERSION

=head1 SYNOPSIS

 use Alien::patch;
 # patch should now be in your PATH if it wasn't already

=head1 DESCRIPTION

Many environments provide the patch command, but a few do not.
Using this module in your C<Build.PL> (or elsewhere) you can
make sure that patch will be available.  If the system provides
it, then great, this module is a no-op.  If it does not, then
it will download and install it into a private location so that
it can be added to the C<PATH> when this module is used.

=head1 METHODS

=head2 exe

 my $exe = Alien::patch->exe;

Returns the command to run patch on your system.  For now it simply
adds the C<--binary> option on Windows (C<MSWin32> but not C<cygwin>)
which is usually what you want.

=cut

my $in_path;

sub import
{
  return if __PACKAGE__->install_type('system');
  return if $in_path;
  unshift @PATH, File::Spec->catdir(__PACKAGE__->dist_dir, 'bin');
  # only do it once.
  $in_path = 1;
}

sub exe
{
  $^O eq 'MSWin32' ? 'patch --binary' : 'patch';
}

1;
