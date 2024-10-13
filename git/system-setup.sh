#!/bin/bash -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# shellcheck source=SCRIPTDIR/../common.sh
. "${script_dir}/../common.sh"

curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh \
  | bash

apt-get update
apt install -y \
  git \
  gitk \
  git-lfs

latest_release_url=$(curl -Ls -o /dev/null -w "%{url_effective}" https://github.com/github/git-sizer/releases/latest)
latest_release_version=${latest_release_url##*/v}

output_name=git-sizer.zip

curl \
  -Ls \
  -o "${output_name}" \
  "https://github.com/github/git-sizer/releases/download/v${latest_release_version}/git-sizer-${latest_release_version}-linux-amd64.zip"


install_dir=/opt/git-sizer
mkdir -p "${install_dir}"
unzip "${output_name}" -d "${install_dir}"

log_success "Installation of Git finished"
