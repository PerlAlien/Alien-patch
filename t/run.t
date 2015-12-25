use strict;
use warnings;
BEGIN {
  unless(eval qq{ use Test::Alien; 1 })
  {
    require Test::More;
    Test::More::plan(skip_all => 'test requires Test::Alien');
  }
}
use Test::Stream -V1;
use Alien::patch;

plan 3;

alien_ok 'Alien::patch';
run_ok(['patch', '--version'])
  ->success
  ->note;
