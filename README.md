# Alien::patch [![Build Status](https://travis-ci.org/PerlAlien/Alien-patch.svg)](http://travis-ci.org/PerlAlien/Alien-patch) ![macos-system](https://github.com/PerlAlien/Alien-patch/workflows/macos-system/badge.svg) ![macos-share](https://github.com/PerlAlien/Alien-patch/workflows/macos-share/badge.svg) ![windows-system](https://github.com/PerlAlien/Alien-patch/workflows/windows-system/badge.svg)

Find or build patch

# SYNOPSIS

```perl
use Alien::patch ();
use Env qw( @PATH );

unshift @PATH, Alien::patch->bin_dir;
my $patch = Alien::patch->exe;
system "$patch -p1 < foo.patch";
```

Or in your [alienfile](https://metacpan.org/pod/alienfile):

```perl
use alienfile;
...
share {
   ...
   # Alien-Build knows to automatically pull in Alien::patch
   # so you do not need to specify it as a prereq.
   # The %{.install.patch} directory is a shortcut for the
   # `patch' directory in your dist, and gets copied into the
   # dist share directory, so you can rebuild with `af' after
   # install.
   patch [ '%{patch} -p1 < %{.install.patch}/mypatch.patch' ];
};
```

Or with [Alien::Build::ModuleBuild](https://metacpan.org/pod/Alien::Build::ModuleBuild):

```perl
use Alien::Base::ModuleBuild;
Alien::Base::ModuleBuild->new(
  ...
  alien_bin_requires => {
    'Alien::patch' => '0.08',
  },
  alien_build_commands => {
    '%{patch} -p1 < foo.patch',
  },
  ...
)->create_build_script;
```

# DESCRIPTION

Many environments provide the patch command, but a few do not.
Using this module in your [alienfile](https://metacpan.org/pod/alienfile) (or elsewhere) you can
make sure that patch will be available.  If the system provides
it, then great, this module is a no-op.  If it does not, then
it will download and install it into a private location so that
it can be added to the `PATH` when this module is used.

This class is a subclass of [Alien::Base](https://metacpan.org/pod/Alien::Base), and works closely
with [Alien::Build](https://metacpan.org/pod/Alien::Build) and [alienfile](https://metacpan.org/pod/alienfile)

# METHODS

## exe

```perl
my $exe = Alien::patch->exe;
```

Returns the command to run patch on your system.  For now it simply
adds the `--binary` option on Windows (`MSWin32` but not `cygwin`)
which is usually what you want.

# HELPERS

## patch

```
%{patch}
```

When used with [Alien::Base::ModuleBuild](https://metacpan.org/pod/Alien::Base::ModuleBuild) in a `alien_build_commands` or `alien_install_commands`,
this helper will be replaced by either `patch` (Unix and cygwin) or `patch --binary` (MSWin32).

# SEE ALSO

- [Alien](https://metacpan.org/pod/Alien)
- [Alien::Build](https://metacpan.org/pod/Alien::Build)
- [alienfile](https://metacpan.org/pod/alienfile)

1;

# AUTHOR

Author: Graham Ollis <plicease@cpan.org>

Contributors:

Zakariyya Mughal

# COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
