# tab completion script of zsh
_projects_complete() {
  local word completions
  word="$1"
  completions="$(projects -l)"
  reply=( "${(ps:\n:)completions}" )
}

compctl -K _projects_complete projects
