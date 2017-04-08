
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
      Y) rm_old && echo "Please rerun install command" && exit ;;
      *) exit
    esac
  else
    mkdir "${rcdir}"
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
  git clone --recursive "${repo_url}"

  # enter git repo
  cd "$(basename ${repo_url})"

  # run binstall
  binstall/binstall.sh projects.sh
}

# run main
main
