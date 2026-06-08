# File: ~/.bashrc

```bash
# bottom of ~/.bashrc

### RJ -----------------------------------

export VISUAL=micro
export EDITOR="$VISUAL"
export SYSTEMD_EDITOR="$VISUAL"
export BROWSER=/usr/bin/microsoft-edge
export PATH="./node_modules/.bin:$PATH"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -e $HOME/.bashrc.aliases ] ; then
   source $HOME/.bashrc.aliases
fi

if [ -d '/var/lib/flatpak/exports/bin' ]; then
    PATH="/var/lib/flatpak/exports/bin:$PATH"
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

eval "$(starship init bash)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

```
