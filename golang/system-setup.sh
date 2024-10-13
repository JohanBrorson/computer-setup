#!/bin/bash -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# shellcheck source=SCRIPTDIR/../common.sh
. "${script_dir}/../common.sh"

latest_release_version=$(curl -s https://go.dev/dl/?mode=json | jq -r '.[0].version')

archive_name="${latest_release_version}.linux-amd64.tar.gz"
outdir=$(mktemp -d -t golang-XXXXXXXX)

curl \
  -Ls \
  -o "${archive_name}" \
  --output-dir "${outdir}" \
  "https://go.dev/dl/${archive_name}"

destination_dir=/usr/local
rm -rf "${destination_dir}/go"
tar -C "${destination_dir}" -xzf "${outdir}/${archive_name}"

log_success "Installation of Go finished"
