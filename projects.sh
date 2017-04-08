#!/usr/bin/env bash

# Author: John D. Anderson
# Email: jander43@vols.utk.edu
# Description: Manage all your projects with the power fo the Unix $SHELL

# globals
cloneterm_url="https://github.com/RagingTiger/cloneterm"
homedir="$HOME/.projectsrc"
notfound="No projects home directory found. To create one run: projects -i"
usage="Usage:
    projects                  Same as 'projects -l' option
    projects -l               Lists all project links
    projects -i               Initializes a '.projectsrc' directory in \$HOME
    projects -r               Removes '.projectsrc' directory
    projects -c [path/to/dir] Create new entry for dir (dir default is \$PWD)
    projects -h               Prints this help message
    projects <prodir>         Opens prodir in subshell
    projects <prodir> -t      Opens prodir in new terminal window
    projects <prodir> -d      Deletes prodir from list"

# funcs
template() {
  tmp="# link for project dir\ndirpath=\$(dirname $1)\necho \"\$dirpath\"\n"
  printf "$tmp"
}

exists() {
  if [ $2 "$1" ]; then
    return 0
  else
    return 1
  fi
}

chk_homedir() {
  return $(exists "$homedir" -d)
}

deref_link() {
  # get path from linked file
  echo "$($homedir/links/$1)"
}

pro_subshell() {
  # open sub shell into cd
  cd $1

  # check for prompt postfix
  if [[ -n "$PROMPT_POSTFIX" ]]; then
    local NEW_POSTFIX="${PROMPT_POSTFIX}:$(basename $1)"
  else
    local NEW_POSTFIX="<Projects> $(basename $1)"
  fi

  # findout which shell and start new shell with prompt postfix
  local subshell=$(basename $SHELL)
  case $subshell in
    zsh)
      # update prompt for sub projects
      export PROMPT_POSTFIX="%F{yellow}${NEW_POSTFIX}"
      # switch to different .zshrc file
      export ZDOTDIR="$HOME/.projectsrc"
      $SHELL
      ;;
  esac

}

pro_help() {
  # print help info
  echo "$usage"
}

pro_term() {
  # macos exclusive command
  if hash cloneterm; then
    cloneterm $1
  else
    echo "cloneterm command not installed. Visit $cloneterm_url for more info."
  fi
}

pro_list() {
  # list out prodir
  if chk_homedir; then
    for i in $(ls "$homedir/links"); do
      echo "$i"
    done
  else
    echo $notfound
  fi
}

pro_remove() {
  if chk_homedir; then
    # prompt for reconsider
    local answer=
    echo -n "Are you sure you want to delete? [Y\n]: "
    read answer

    # check
    case $answer in
      "Y") rm -rf "$homedir" && echo "Home projects directory deleted"
    esac
  else
    # no directory found
    echo $notfound
  fi
}

pro_navigate() {
  # check link existence
  if exists "$homedir/links/$1" -e; then
    # now get path to project
    local propath=$(deref_link $1)

    # check path
    if exists $propath -d; then
      case $2 in
        "-t"|"term") pro_term $propath ;;
        "-d"|"delete") prodir_file_delete $propath $1 ;;
        *) pro_subshell $propath $1;;
      esac

    # link is broken
    else
      echo "Project path not found: $propath"
    fi

  else
    # link not found
    echo "Link to $1 project not found"
  fi

}

pro_init() {
  # return path to init script
  echo "${homedir}/projects-gitrepo/_completions/init.sh"
}

pro_link() {
  # operate on path
  local dir=$(dirname $1)
  local base=$(basename $dir)

  # check for links
  if [ -e "$homedir/links/$base" ]; then
    echo "$base"
  else
    echo "$base"
  fi
}

prodir_file_create() {
  local prpath="$1/.projectdir"
  # create file
  touch $prpath && chmod +x $prpath && echo "$(template $prpath)" > $prpath
  # get link name
  local plink=$(pro_link $prpath)
  # create link
  ln $prpath "$homedir/links/$plink"
}

prodir_file_delete() {
  prpath="$1/.projectdir"
  # delete projectdir file
  rm $prpath
  # now delete link
  rm $homedir/links/$2
}

prodir_chk() {
  # base of path
  base=$(basename $1)
  # check if exists
  if exists "$homedir/links/$base" -e; then
    echo "Project is already listed"
  else
    prodir_file_create $1
  fi
}

pro_create() {
  # check arg 2
  if [ -n "$1" ]; then
    # link
    prodir_chk "$PWD/$1"
  else
    # use $PWD
    prodir_chk $PWD
  fi
}


# run main
if [ -z "$1" ]; then
  pro_list
else
  case "$1" in
    "-i") pro_init ;;
    "-r") pro_remove ;;
    "-l") pro_list ;;
    "-h") pro_help ;;
    "-c") pro_create "$2" ;;
    *) pro_navigate "$1" "$2" ;;
  esac
fi
