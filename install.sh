#!/bin/bash -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# shellcheck source=SCRIPTDIR/common.sh
. "${script_dir}/common.sh"

function usage {
  echo "Usage: sudo $(basename "$0")"
  echo "Install application and tools"
  exit 1
}

is_supported_os

if [[ -z $SUDO_USER ]]; then
  usage
fi

"${script_dir}/essential/install.sh"

for directory in "$script_dir"/*; do
  if [ -d "${directory}" ] && [ "$(basename "${directory}")" != "essential" ]; then
    if [ -f "${directory}/install.sh" ]; then
      "${directory}/install.sh"
    fi
  fi
done

log_success "Installation finished"
