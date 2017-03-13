## About
The **projects** command is exactly what it sounds like: a command line tool
for easily managing your projects. This includes instant navigation (through a
subshell or opening a new terminal window) and instant viewing of meta
information about the project (i.e. todolists, notes, etc...)

## Install
To install the **projects** utility, we need to start by cloning the project
to our local machine with a special "recursive" command (to make sure the
submodules are downloaded as well):

```
git clone --recursive https://github.com/RagingTiger/projects
```

Next you simply `cd` into the directory, and run the `configure` file:

```
cd projects/
./configure
```

That's it, you are ready to start using the **projects** command. First you will
want to setup your `$HOME/.projectsrc` file:

```
projects -i
```

Now you can start adding project directories to your list of projects!

## Usage
```
  projects                  Same as 'projects -l' option
  projects -l               Lists all project links
  projects -i               Initializes a '.projectsrc' directory in $HOME
  projects -r               Removes '.projectsrc' directory
  projects -c [path/to/dir] Create new entry for dir (dir default is \$PWD)
  projects -h               Prints this help message
  projects <prodir>         Opens prodir in subshell
  projects <prodir> -t      Opens prodir in new terminal window
  projects <prodir> -d      Deletes prodir from list
```
