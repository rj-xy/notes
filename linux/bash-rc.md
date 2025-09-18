# File: ~/.bashrc

```bash
# bottom of ~/.bashrc

### RJ -----------------------------------

export VISUAL=nano
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

if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source "$HOME/.bash-git-prompt/gitprompt.sh"
fi

if [ -e '/usr/local/bin/aws_completer' ] ; then
  complete -C '/usr/local/bin/aws_completer' aws
fi

if [ -d '/var/lib/flatpak/exports/bin' ]; then
    PATH="/var/lib/flatpak/exports/bin:$PATH"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

```
