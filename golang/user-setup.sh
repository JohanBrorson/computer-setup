#!/bin/bash -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# shellcheck source=SCRIPTDIR/../common.sh
. "${script_dir}/../common.sh"

if ! grep "export PATH=\$PATH:/usr/local/go/bin" "$HOME/.bashrc" >/dev/null; then
  echo "# Add Go the PATH environment variable" >>"$HOME/.bashrc"
  echo "export PATH=\$PATH:/usr/local/go/bin" >>"$HOME/.bashrc"
fi

if ! grep "export PATH=\$PATH:$HOME/go/bin" "$HOME/.bashrc" >/dev/null; then
  echo "export PATH=\$PATH:$HOME/go/bin" >>"$HOME/.bashrc"
fi


log_success "Configuration of Go finished"
