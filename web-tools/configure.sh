#!/bin/bash -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# shellcheck source=SCRIPTDIR/../common.sh
. "${script_dir}/../common.sh"

if ! command -v curl >/dev/null 2>&1; then
  log_failure "curl is not installed"
fi

# Change npm's default directory. Avoid permissions errors when installing packages globally.
NPM_GLOBAL_DIR=$HOME/.npm-global
mkdir -p "$NPM_GLOBAL_DIR"
npm config set prefix "$NPM_GLOBAL_DIR"
if ! grep "$NPM_GLOBAL_DIR" "$HOME/.bash_profile" >/dev/null; then
  echo "export PATH=\$PATH:$NPM_GLOBAL_DIR" >> $HOME/.bash_profile
fi

# Install Yarn
npm install --global yarn

# Install Node Version Manager
latest_nvm_release_url=$(curl -Ls -o /dev/null -w "%{url_effective}" https://github.com/nvm-sh/nvm/releases/latest)
latest_nvm_release_version=${latest_nvm_release_url##*/}
wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/${latest_nvm_release_version}/install.sh" | \
bash

# Install Yarn Version Manager
wget -qO- https://raw.githubusercontent.com/tophat/yvm/master/scripts/install.js | \
YVM_INSTALL_DIR="$HOME/.yvm/.yarn" node

log_success "Configuration of web tools finished"
