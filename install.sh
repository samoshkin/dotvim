#!/usr/bin/env bash

set -e
set -o pipefail

exists() {
  which "$1" >/dev/null 2>&1
}

check_app(){
  local GREEN='\033[0;32m'
  local RED='\033[0;31m'
  local BOLD='\033[1m'
  local RESET='\033[0m'

  if exists "$1"; then
    echo -e "  ${GREEN}✅${RESET} ${BOLD}$1${RESET}"
  else
    echo -e "  ${RED}❗${RESET} ${BOLD}$1${RESET}"
  fi
}

# coc.nvim. Install extensions
echo -e 'Install coc extensions at: ~/.config/coc/extensions'
mkdir -p "$HOME/.config/coc/extensions"
ln -sf "$HOME/.vim/coc-extensions.json" "$HOME/.config/coc/extensions/package.json"
pushd "$HOME/.config/coc/extensions" > /dev/null
yarn install
popd > /dev/null

echo -e ''
echo -e 'Looking up for required programs'
check_app git
check_app bat
check_app fzf
check_app delta
check_app rg
check_app nnn
check_app ctags
