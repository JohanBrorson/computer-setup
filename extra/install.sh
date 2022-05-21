#!/bin/bash -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# shellcheck source=SCRIPTDIR/../common.sh
. "${script_dir}/../common.sh"

apt-get update
apt install -y \
build-essential \
jq \
keepassx \
net-tools \
shellcheck \
virtualbox

log_success "Installation of extra packages finished"
