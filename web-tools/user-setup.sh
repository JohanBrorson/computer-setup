#!/bin/bash -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# shellcheck source=SCRIPTDIR/../common.sh
. "${script_dir}/../common.sh"

if ! command -v curl >/dev/null 2>&1; then
  log_failure "curl is not installed"
fi

# Install Node Version Manager
latest_nvm_release_url=$(curl -Ls -o /dev/null -w "%{url_effective}" https://github.com/nvm-sh/nvm/releases/latest)
latest_nvm_release_version=${latest_nvm_release_url##*/}
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${latest_nvm_release_version}/install.sh" \
  | bash

. "$HOME/.nvm/nvm.sh"

# Install latest LTS version
nvm install --lts

corepack enable

log_success "Configuration of web tools finished"
