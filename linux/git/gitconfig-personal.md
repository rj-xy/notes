# File: ~/.gitconfig (Personal)

```
# Gen SSH key
ssh-keygen -t ed25519 -C "your_email@example.com"
```

```
[includeIf "gitdir:~/src-gl/"]
  path = ~/.gitconfig-gitlab

[includeIf "gitdir:~/src-gh/"]
  path = ~/.gitconfig-github

[color]
 ui = true

[core]
 editor = code -n -w
[sequence]
 editor = code -n -w

[rebase]
 autosquash = true

[pull]
 rebase = true

# MERGE

[merge]
  tool = kdiff3
  guitool = kdiff3
  keepBackup = false

[mergetool]
  keepBackup = false

[mergetool "code"]
  path = /usr/bin/code

[mergetool "kdiff3"]
  path = /usr/bin/kdiff3

# DIFF

[diff]
  tool = kdiff3
  guitool = kdiff3
  keepBackup = false

[difftool "code"]
  path = /usr/bin/code

[difftool "kdiff3"]
  path = /usr/bin/kdiff3
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
