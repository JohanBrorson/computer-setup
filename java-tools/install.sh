#!/bin/bash -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# shellcheck source=SCRIPTDIR/../common.sh
. "${script_dir}/../common.sh"

# Import the Corretto public key and add the repository
wget -O- https://apt.corretto.aws/corretto.key | \
apt-key add -
echo "deb https://apt.corretto.aws stable main" | \
tee /etc/apt/sources.list.d/corretto.list

apt-get update
apt install -y \
java-11-amazon-corretto-jdk \
maven

log_success "Installation of Java tools finished"
