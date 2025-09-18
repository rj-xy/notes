# File: ~/.bash_aliases

```sh
#! /bin/bash
#
# ~/.bash_aliases
#

# sudo uname to prompt for password before running
alias update='sudo uname && flatpak uninstall --unused -y && flatpak update -y && sudo snap refresh && sudo apt update && sudo apt upgrade -y && sudo fwupdmgr refresh --force && sudo fwupdmgr update'

alias clear-dns='sudo cp /etc/resolv.conf-bak /etc/resolv.conf'
alias journalctl='sudo journalctl'

# stop all containers:
alias docker-kill='docker kill $(docker ps -q)'
# remove all containers
alias docker-rm='docker rm $(docker ps -a -q)'
# remove all docker images
alias docker-rmi='docker rmi -f $(docker images -q)'
# remove all docker volumes
alias docker-rmvol='docker volume ls -qf dangling=true | xargs -r docker volume rm'
# stop & remove all containers/volumes
alias docker-clean='docker-kill || true && docker-rm || true && docker-rmvol || true && docker-rmi'
alias docker-cl='docker-kill || true && docker-rm || true && docker-rmvol'

alias dc='docker-compose'

alias git-wip='git add . && git commit -a -m "#WIP"'
alias git-fetch='git fetch --all --prune'
alias git-log='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)"'
alias git-lg='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)"'

alias git-rebase='git rebase -i origin/staging'
alias git-staging='git checkout -B "staging" "origin/staging"'
alias git-ff='git checkout -B $(git branch --show-current) $(git remote show)/$(git branch --show-current)'
alias git-push='git push --force-with-lease'

alias kill-node="killall --signal SIGKILL -exact node"
alias kill-ssh="killall ssh"
```
