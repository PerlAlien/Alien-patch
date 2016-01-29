package My::ModuleBuild;

use strict;
use warnings;
use base qw( Alien::Base::ModuleBuild );
use Capture::Tiny qw( capture );
use File::chdir;

sub alien_check_installed_version
{
  my($self) = @_;
  my($stdout, $stderr, $ret) = capture { system 'patch', '--version'; $? };
  return if $ret;
  return $1 if $stdout =~ /patch ([0-9.]+)/i;
  return $1 if $stdout =~ /patch version ([0-9.])/i;
  return 'unknwon';
}

sub alien_check_built_version
{
  $CWD[-1] =~ /^patch-(.*)$/ ? $1 : 'unknown';
}

1;
