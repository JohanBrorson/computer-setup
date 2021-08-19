#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# shellcheck source=SCRIPTDIR/../common.sh
. "${script_dir}/../common.sh"

cp --backup=numbered "$script_dir/.gitconfig" "$HOME/"

log_success "Configuration of Git finished"
