# Git commands

## **BAU

### Push origin (one-time) (-u = set upstream)
* git push -u origin branch-name

### Delete all files not tracked by Git
* git clean -fdx

### When rebase interactive, and you want to deconstruct the current commit
* git reset HEAD~
* git reset HEAD~0
* git reset HEAD~2

### Rebase starting on the first commit
git rebase -i --root

## **CONFIG

### Get Fetch|Push urls
* git remote get-url origin
* git remote get-url --push origin

### Show fetch and push urls (either)
* git remote show origin
* git remote -v

### Set Fetch|Push urls
* git remote set-url origin [git repo]
* git remote set-url upstream [git repo]
* git remote set-url --push [git repo]

### Set upstream (SAME-SAME)
* git branch -u origin/[branch]
* OR
* git branch --set-upstream-to origin/[branch]

### Set a new remote
* git remote add [remote name] [git repo]
