# tab completion script of zsh
_projects_complete() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"
  local completions="$(projects -l)"
  COMPREPLY=( $(compgen -W "$completions" -- "$word") )
}

complete -F_projects_complete projects
