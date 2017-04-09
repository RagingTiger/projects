<p align="center">
  <img src="https://github.com/RagingTiger/gifs/raw/fe968e99fa0d5c27ed1b6a65814d459fd26f305d/projects.gif"/>
</p>


## About
The **projects** command is exactly what it sounds like: a command line tool
for easily managing your projects. This includes instant navigation (through a
subshell or opening a new terminal window) and instant viewing of meta
information about the project (i.e. todolists, notes, etc...)

## Install
<p align="center">
  <img src="https://github.com/RagingTiger/gifs/raw/be6541adf942b60917f4864bce256220c180e740/projects_install.gif"/>
</p>

As the above GIF shows, to install you want to copy the text below into a
terminal (excluding the '$' symbol):

```
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/RagingTiger/projects/e628964fd602c65da9b17fb09369f7a05306dcdb/install.sh)"
```



## Usage
```
  projects                  Same as 'projects -l' option
  projects -l               Lists all project links
  projects -r               Removes '.projectsrc' directory
  projects -c [path/to/dir] Create new entry for dir (dir default is $PWD)
  projects -h               Prints this help message
  projects -u               Updates 'projects' to most recent version
  projects <prodir>         Opens prodir in subshell
  projects <prodir> -t      Opens prodir in new terminal window
  projects <prodir> -d      Deletes prodir from list
```
