#!/bin/bash -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# shellcheck source=SCRIPTDIR/../common.sh
. "${script_dir}/../common.sh"

# Import the Docker public key and add the repository
wget -O- https://download.docker.com/linux/ubuntu/gpg \
  | gpg --dearmor --batch --yes -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | tee /etc/apt/sources.list.d/docker.list

apt-get update
apt install -y \
  containerd.io \
  docker-ce \
  docker-ce-cli

getent group docker || groupadd docker
usermod -aG docker "$SUDO_USER"

# Install Docker Compose
cli_plugins_dir=/usr/local/lib/docker/cli-plugins
mkdir -p "${cli_plugins_dir}"
docker_compose_path=${cli_plugins_dir}/docker-compose
latest_compose_release_url=$(curl -Ls -o /dev/null -w "%{url_effective}" https://github.com/docker/compose/releases/latest)
latest_compose_release_version=${latest_compose_release_url##*/}
wget "https://github.com/docker/compose/releases/download/${latest_compose_release_version}/docker-compose-$(uname -s)-$(uname -m)" -O $docker_compose_path
chmod +x $docker_compose_path

log_success "Installation of Docker finished"
