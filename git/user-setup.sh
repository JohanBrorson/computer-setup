#!/bin/bash -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# shellcheck source=SCRIPTDIR/../common.sh
. "${script_dir}/../common.sh"

if ! command -v git >/dev/null 2>&1; then
  log_failure "git is not installed"
fi

cp --backup=numbered "$script_dir/.gitconfig" "$HOME/"

if ! grep /usr/share/bash-completion/completions/git "$HOME/.bashrc" >/dev/null; then
  {
    echo "# Enable git auto-completion"
    echo "[ -f /usr/share/bash-completion/completions/git ] && . /usr/share/bash-completion/completions/git"
    echo ""
  } >> "$HOME/.bashrc"
fi

# Include git in the shell prompt. See example below.
# Before: PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# After:  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1 " (%s)")\$ '
if ! grep __git_ps1 "$HOME/.bashrc" >/dev/null; then
  # shellcheck disable=SC2016
  sed -i.bak 's/PS1=\(.*\)\\$ /PS1=\1$(__git_ps1 " (%s)")\\$ /' "$HOME/.bashrc"
fi

if ! grep GIT_PS1 "$HOME/.bashrc" >/dev/null; then
  {
    echo "# Configure git prompt"
    echo "GIT_PS1_SHOWDIRTYSTATE=1"
    echo "GIT_PS1_SHOWUNTRACKEDFILES=1"
    echo ""
  } >> "$HOME/.bashrc"
fi

git_sizer_path=/opt/git-sizer/git-sizer
if ! grep "export PATH=\$PATH:${git_sizer_path}" "$HOME/.bashrc" >/dev/null; then
  {
    echo "# Add git-sizer to the PATH environment variable"
    echo "export PATH=\$PATH:${git_sizer_path}"
    echo ""
  } >>"$HOME/.bashrc"
fi

log_success "Configuration of Git finished"
