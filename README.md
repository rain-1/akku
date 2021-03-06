# Akku.scm

[![Build Status](https://travis-ci.org/weinholt/akku.svg?branch=master)](https://travis-ci.org/weinholt/akku)
[![pipeline status](https://gitlab.com/akkuscm/akku/badges/master/pipeline.svg)](https://gitlab.com/akkuscm/akku/commits/master)

> "The purpose of the machine is to make drudgery unnecessary."
>
> &mdash; Alan Watts

Akku.scm is a language package manager for Scheme. It grabs hold of
code and vigorously shakes it until it behaves properly.

* Separately declare your dependencies and locked versions.
* One command to install everything needed for a project.
* Project-based, installs your locked dependencies to a single library
  directory.
* Scan repositories for R6RS/R7RS libraries, even multiple per file,
  and copy them to the right file paths for any supported Scheme.
* Resolve all files needed for compilation and scan them for license
  notices.

Web site: [akkuscm.org](https://akkuscm.org/).

## Dependencies

Akku.scm currently requires the git and curl programs. Publishing
requires GnuPG. It has only been tested on GNU/Linux systems.
Assistance in porting is very welcome.

## Installation

There are two options:

 - Download, unpack and run the binary installer
   from [GitHub](https://github.com/weinholt/akku/releases). Pre-built
   versions are available for GNU/Linux amd64. The installation is
   completely contained to `~/.akku`.

 - Download the source bundle
   from [GitHub](https://github.com/weinholt/akku/releases) (files
   ending with `+src.tar.xz`). This version is a little slower and
   takes longer to install, but runs on more types of systems. It
   requires Chez Scheme 9.5+ or GNU Guile 2.2+.

Please remember to verify the OpenPGP signatures. The releases are
signed with [E33E61A2E9B8C3A2][key].

 [key]: https://pgp.surfnet.nl/pks/lookup?op=vindex&fingerprint=on&search=0xE33E61A2E9B8C3A2

## Usage

Here's a high level view of how to get started:

 - Create a new directory for your project or go to your existing
   project directory.
 - Run `akku list` to list the packages (`akku update` downloads the
   package index).
 - Run `akku install <pkg>` to install a named package. This also
   installs the code in your current directory into `.akku`.
 - Run `source .akku/bin/activate` (in bash) to prepare the
   environment for the programs and libraries in `.akku`.

The installed libraries and programs should now be available to you,
assuming you use one of these Schemes: Chez Scheme, GNU Guile (with
R6RS settings), Ikarus, Larceny, Mosh, Racket (plt-r6rs), Sagittarius,
Vicare or Ypsilon.

More details are in the manpage: `man docs/akku.1`.

## License

Akku.scm is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation, either version 3 of the License, or (at your
option) any later version.
