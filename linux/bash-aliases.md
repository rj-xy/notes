# File: ~/.bash_aliases

```sh
#! /bin/bash
#
# ~/.bash_aliases
#

alias get_idf='. ~/.espressif/v5.5.2/esp-idf/export.sh'

alias update-ghosty='/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"'
alias update-lazydocker='curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash'
alias update-gah='gah install lazygit --unattended && gah install lazydocker --unattended'
alias update-shellcheck='gah install koalaman/shellcheck --unattended'

# sudo uname to prompt for password before running
function update () {
  sudo uname
  gah update
  update-gah
  update-shellcheck
  flatpak uninstall --unused -y
  flatpak update -y
  sudo snap refresh
  sudo apt update
  sudo apt upgrade -y
  update-ghosty
  sudo fwupdmgr refresh --force
  sudo fwupdmgr update
}

alias journalctl='sudo journalctl'

alias edit='/usr/bin/micro'
alias e='/usr/bin/micro'

export AWS_PROFILE="tech-dev"

SAURON_ROOT=~/src/sauron
source $SAURON_ROOT/infrastructure/scripts/git.sh
source $SAURON_ROOT/infrastructure/scripts/hubs.sh
source $SAURON_ROOT/infrastructure/scripts/docker.sh
source $SAURON_ROOT/infrastructure/scripts/jumpbox.sh
```
