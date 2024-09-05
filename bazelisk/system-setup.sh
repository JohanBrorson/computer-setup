#!/bin/bash -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# shellcheck source=SCRIPTDIR/../common.sh
. "${script_dir}/../common.sh"

latest_release_url=$(curl -Ls -o /dev/null -w "%{url_effective}" https://github.com/bazelbuild/bazelisk/releases/latest)
latest_release_version=${latest_release_url##*/}

output_dir=/usr/local/bin
output_name=bazelisk

curl \
  -Ls \
  -o "${output_name}" \
  --output-dir "${output_dir}" \
  "https://github.com/bazelbuild/bazelisk/releases/download/${latest_release_version}/bazelisk-linux-amd64"

chmod +x "${output_dir}/${output_name}"

log_success "Installation of Bazelisk finished"
