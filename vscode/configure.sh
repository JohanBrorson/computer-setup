#!/bin/bash -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# shellcheck source=SCRIPTDIR/../common.sh
. "${script_dir}/../common.sh"

code_cmd=code

if ! command -v $code_cmd >/dev/null 2>&1; then
  log_failure "$code_cmd is not installed!"
fi

mkdir -p "$HOME/.config/Code/User/"
cp --backup=numbered "$script_dir/settings.json" "$HOME/.config/Code/User/"

extensions=(
  "bitzl.vscode-puppet" \
  "dbaeumer.vscode-eslint" \
  "eamodio.gitlens" \
  "esbenp.prettier-vscode" \
  "foxundermoon.shell-format" \
  "GitHub.vscode-pull-request-github" \
  "kumar-harsh.graphql-for-vscode" \
  "lokalise.i18n-ally" \
  "ms-azuretools.vscode-docker" \
  "ms-kubernetes-tools.vscode-kubernetes-tools" \
  "ms-python.python" \
  "ms-python.vscode-pylance" \
  "ms-vscode.cmake-tools" \
  "ms-vscode.cpptools" \
  "ms-vsliveshare.vsliveshare" \
  "redhat.vscode-yaml" \
  "ritwickdey.LiveServer" \
  "rust-lang.rust" \
  "twxs.cmake" \
  "vadimcn.vscode-lldb" \
  "whatwedo.twig"
)

for extension in "${extensions[@]}"
do
  $code_cmd --force --install-extension "$extension"
done

log_success "Configuration of VS Code finished"
