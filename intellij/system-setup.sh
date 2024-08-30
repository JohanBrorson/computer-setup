#!/bin/bash -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# shellcheck source=SCRIPTDIR/../common.sh
. "${script_dir}/../common.sh"

snap install intellij-idea-community --classic

# Increase inotify watch limit
sysctl_file=/etc/sysctl.d/50-inotify-max-user-watches.conf
max_user_watches_config="fs.inotify.max_user_watches = 524288"
if ! grep -s -q "$max_user_watches_config" "$sysctl_file"; then
  echo "$max_user_watches_config" >> "$sysctl_file"
fi

# Apply the inotify watch limit changes
sysctl -p --system

log_success "Installation of IntelliJ IDEA finished"
