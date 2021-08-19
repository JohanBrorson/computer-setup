#!/bin/bash -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# shellcheck source=SCRIPTDIR/../common.sh
. "${script_dir}/../common.sh"

# Enable key bindings and auto-completion for fzf
if ! grep /usr/share/doc/fzf/examples/key-bindings.bash "$HOME/.bashrc" >/dev/null; then
  echo "# Enable fzf key bindings" >> "$HOME/.bashrc"
  echo "[ -f /usr/share/doc/fzf/examples/key-bindings.bash ] && . /usr/share/doc/fzf/examples/key-bindings.bash" >> "$HOME/.bashrc"
fi

if ! grep /usr/share/doc/fzf/examples/completion.bash "$HOME/.bashrc" >/dev/null; then
  echo "# Enable fuzzy auto-completion" >> "$HOME/.bashrc"
  echo "[ -f /usr/share/doc/fzf/examples/completion.bash ] && . /usr/share/doc/fzf/examples/completion.bash" >> "$HOME/.bashrc"
fi

log_success "Configuration of fzf finished"
