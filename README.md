#Gittify

Customized bash environment, making git folders more friendly.

This project provides bash/git customization files. Running the
**gittify** command, starts a new **bash** shell and overrides
its console PS1.
New console line informs about the state of current git
working copy (e.g. name of the current branch) in a colorful manner.

Also some aliases are defined in **.gitconfig** file. **Appending** them
to your own .gitconfig file provides more functionality (listed below).
See Installation section for more details.

Moreover, it allows customizing user name/email based on the remote repos.

##Most useful aliases
For all aliases, look in the homefolder/.gitconfig file :) But most useful
ones are as follows:

 * git lg

   Prints a colorful one-line-per-commit log.

 * git tree
 
   Same as `git lg --graph`; showing graph of commits.

 * git st

   Prints the status.

 * git unstage _somefile_

   Unstages the _somefile_.

##Installation

### Automatic

Run `make install-user` to install into your local user
or run `sudo make install-root` to install system-wide.

### Manual

1. Copy _bin/gittify_ file into _~/bin/_ folder (or add it to the $PATH),
2. Copy _homefolder/git.bashrc_ file to _$HOME/.gittify/git.bashrc_ (gittify script uses it),
3. **Append** contents of _homefolder/.gitconfig_ to your _.gitconfig_ file.
  * if (your git version older than 1.7.11): use _.gitconfig.before-git-1.7.11_ instead of _.gitconfig_ file

## Customizing Name/Email

If you want to have different name/email configurations based on
the remote repository, like using test < test@test.com > for github.com repos
while committing as work < work@work.com > to ssh://other@www.gitlab.com repos, then
create a section in the config file for each repo and name it as the domain name
from the URL of that repo. Then define name/email variables in that section like
the default settings of the [user] section.

The gittify checks URL of the **origin** remote for **push** target, extracts
its domain name, and uses its defined name/email (if any) instead of default values.
Upon changing name/email configs, new values are printed on the console too.

As an example, for the above example (with test and work user/email configs), put
following lines in the config file:

```ini
[github.com]
  name = test
  email = test@test.com
[www.gitlab.com]
  user = work
  email = work@work.com
```

##License
    Copyright © 2013-2015  Behnam Momeni

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
