#!/bin/bash -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# shellcheck source=SCRIPTDIR/common.sh
. "${script_dir}/common.sh"

function usage {
  echo "Usage: $(basename "$0")"
  echo "Configures application and tools"
  exit 1
}

is_supported_os

if [[ -n $SUDO_USER ]]; then
  usage
fi

for directory in "$script_dir"/*; do
  if [ -d "${directory}" ]; then
    if [ -f "${directory}/configure.sh" ]; then
      "${directory}/configure.sh"
    fi
  fi
done

log_success "Configuration finished"
