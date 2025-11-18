# File: ~/.gitconfig (Work)

```
# Gen SSH key
ssh-keygen -t ed25519 -C "rj@xxxxxxx"
# Add SSH To Github

# Gen GPG key
gpg --full-gen-key
gpg --list-secret-keys --keyid-format=long
gpg --armor --export <ID>
# Add GPG To Github
```

```
# ~/.gitconfig

[includeIf "gitdir:~/src/"]
  path = ~/.gitconfig-gh

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


# ~/.gitconfig-gh
```
[user]
  name = Richard J
  email = rj@xxxxxx
  signingkey = xxxxxxxxxxx

[commit]
  gpgsign = true

[core]
  sshCommand = ssh -i ~/.ssh/id_github

```


## PASSWORD - if using

`git credential-cache exit`
```
[credential]
  helper = cache --timeout=30000
```
