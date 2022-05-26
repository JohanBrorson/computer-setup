#!/bin/bash -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# shellcheck source=SCRIPTDIR/../common.sh
. "${script_dir}/../common.sh"

if ! command -v python3 >/dev/null 2>&1; then
  log_failure "python3 is not installed!"
fi

apt-get update
apt install -y \
python3-pip \
python3-venv \
flake8

log_success "Installation of Python tools finished"
