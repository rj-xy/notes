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
[includeIf "gitdir:~/src/"]
  path = ~/.gitconfig-gh

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

[filter "lfs"]
    clean = git-lfs clean -- %f
    smudge = git-lfs smudge -- %f
    process = git-lfs filter-process
    required = true

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
