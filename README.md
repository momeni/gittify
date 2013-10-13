#Gittify

Customized bash environment, making git folders more friendly.

This project provides bash/git customization files. Running the
**gittify** command, starts a new **bash** shell and overrides
its console PS1.
New console line informs about the state of current git
working copy (e.g. name of the current branch) in a colorful manner.

Also some aliases are defined in **.gitconfig** file. **Appending** them
to your own .gitconfig file provides more functionality (listed below).
**DO NOT OVERWRITE your .gitconfig containing your username, email, etc.**

##Most useful aliases
For all aliases, look in the homefolder/.gitconfig file :) But most useful
ones are as follows:

 * git lg

   Prints a colorful one-line-per-commit log.

 * git st

   Prints the status.

 * git unstage _somefile_

   Unstages the _somefile_.

##Installation

1. Copy _bin/gittify_ file into _~/bin/_ folder (or add it to the $PATH),
2. Copy _homefolder/git.bashrc_ file to your _home folder_ (gittify script uses it),
3. **Append** contents of _homefolder/.gitconfig_ to your _.gitconfig_ file.

##License
    Copyright © 2013  Behnam Momeni

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see {http://www.gnu.org/licenses/}.
