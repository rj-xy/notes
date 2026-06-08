# File: ~/.bash_aliases

```sh
#!/usr/bin/env bash

alias get_idf='. ~/.espressif/v5.5.2/esp-idf/export.sh'

# sudo uname to prompt for password before running
function update () {
  sudo uname
  flatpak uninstall --unused -y
  flatpak update -y
  sudo snap refresh
  sudo apt update
  sudo apt upgrade -y
  sudo fwupdmgr refresh --force
  sudo fwupdmgr update
}

alias journalctl='echo "⚠️⚠️⚠️Try lazyjournal⚠️⚠️⚠️" && sudo journalctl'

alias edit='/usr/bin/micro'
alias e='/usr/bin/micro'
```
