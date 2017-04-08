
# globals
zshrc='
# first source users shell rc file
source "$HOME/.$(basename $SHELL)rc"

# update prompt for subshells
if [[ -n "$PROMPT_POSTFIX" ]]; then
  local newline=$'"'"'\\n'"'"'
  export PS1="${newline}${PROMPT_POSTFIX}${newline}${PS1}"
fi'
repo_url="https://github.com/RagingTiger/projects"
rctab_cmp='which projects > /dev/null && . $( projects -i )'
rcdir=$"$HOME/.projectsrc"

# funcs
gen_zshrc() {
  echo "${zshrc}" >> "${rcdir}/.zshrc"
}

rm_old() {
  # check /usr/local/bin
  if [[ -e /usr/local/bin/projects ]]; then
    rm /usr/local/bin/projects
  fi
  # remove .projectsrc
  rm -rf "${rcdir}"
}

check_rcdir() {
  if [[ -d "$rcdir" ]]; then
    # ask to delete
    local answer=
    printf '.projectsrc directory already exists. Delete? [Y/n]: '
    read answer

    # check answer
    case "$answer" in
      Y) rm_old && echo ".projecstrc removed, now rerun install"
         exit
         ;;
      *) exit
    esac
  else
    mkdir "${rcdir}"
  fi
}


tab_comp() {
  # check shell rc file
  local shellrc="$HOME/.$(basename $SHELL)rc"
  if [[ -f "$shellrc" ]]; then
    # check rc file
    if cat "$shellrc" | grep "${rctab_cmp}"; then
      # pass
      :

    else
      # ask to setup tab complete
      local answer=
      printf "Do you want to setup tab complete (recommended)? [Y/n]: "
      read answer

      # check answer
      case "$answer" in
        Y)
          echo "Adding ${rctab_cmp} to your ${shellrc} file ..."
          echo "${rctab_cmp}" >> "${shellrc}"
          ;;
        *)
          # do nothing
          :
         ;;
      esac
    fi

  else
    echo "No shell rc file found"
  fi
}

main() {
  # first make .projectsrc dir
  check_rcdir

  # go to rcdir
  cd "${rcdir}" && mkdir "links"

  # gen .zshrc
  gen_zshrc

  # then clone projects src to .projectsrc dir
  local srcdir="$(basename ${repo_url})-gitrepo"
  git clone --recursive "${repo_url}" "${srcdir}"

  # enter git repo
  cd "${srcdir}"

  # run binstall
  binstall/binstall.sh projects.sh

  # install tab complete
  tab_comp
}

# run main
main
