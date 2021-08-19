#!/bin/bash -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# shellcheck source=SCRIPTDIR/../common.sh
. "${script_dir}/../common.sh"

# Import the Docker public key and add the repository
wget -O- https://download.docker.com/linux/ubuntu/gpg | \
gpg --dearmor --batch --yes -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
tee /etc/apt/sources.list.d/docker.list

apt-get update
apt install -y \
containerd.io \
docker-ce \
docker-ce-cli

getent group docker || groupadd docker
usermod -aG docker "$SUDO_USER"

log_success "Installation of Docker finished"
