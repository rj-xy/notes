# File: ~/.gitconfig (Personal)

```
# Gen SSH key
ssh-keygen -t ed25519 -C "your_email@example.com"
```

```
# ~/.gitconfig

[includeIf "gitdir:~/src-gl/"]
  path = ~/.gitconfig-gitlab

[includeIf "gitdir:~/src-gh/"]
  path = ~/.gitconfig-github

[color]
ui = true

[core]
editor = cursor -n -w

[sequence]
editor = cursor -n -w

[rebase]
autosquash = true

[push]
 autoSetupRemote = true

[pull]
rebase = true

# MERGE
[merge]
# tool = kdiff3 | cursor
 tool = kdiff3
# guitool = kdiff3 | cursor
 guitool = kdiff3
 keepBackup = false

[mergetool]
  keepBackup = false

[mergetool "cursor"]
 path = /usr/bin/cursor

[mergetool "code"]
 path = /usr/bin/code
# MacOS:
# path = /usr/local/bin/code

[mergetool "kdiff3"]
 path = /usr/bin/kdiff3
# MacOS:
# path = /opt/homebrew/bin/kdiff3

# DIFF
[diff]
# tool = kdiff3 | code
 tool = kdiff3
# guitool = kdiff3 | code
 guitool = kdiff3
 keepBackup = false

[difftool]
 keepBackup = false

[difftool "cursor"]
 path = /usr/bin/cursor

[difftool "code"]
 path = /usr/bin/code
# MacOS:
# path = ???

[difftool "kdiff3"]
 path = /usr/bin/kdiff3
# MacOS:
# path = /opt/homebrew/bin/kdiff3

```


# ~/.gitconfig-github

```
[user]
  name = rj-xy
  email = 2442596+rj-xy@users.noreply.github.com

[core]
  sshCommand = ssh -i ~/.ssh/id_github_rj
```


# ~/.gitconfig-gitlab

```
[user]
  name = rj-xy
  email = 3405857-rj-xy@users.noreply.gitlab.com

[core]
  sshCommand = ssh -i ~/.ssh/id_gitlab_rj
```
