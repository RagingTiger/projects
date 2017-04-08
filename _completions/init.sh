# control flow for bash/zsh shells
if [[ -n "$BASH_VERSION" ]]; then
  local root="$(dirname "${BASH_SOURCE[0]}")"
  source "${root}/projects-complete.bash"
elif [[ -n "$ZSH_VERSION" ]]; then
  local root="$(dirname $0)"
  source "${root}/projects-complete.zsh"
fi
