Git Revert

git revert -m 1 cd5149b8ef56f40cefaca602184e0cf9b2ca9367

The One-Liner Command
Run this command in your terminal. It automatically filters out your current branch, main, and anything starting with release/, then deletes the rest:

git branch | grep -vE '^\*|main|release/' | xargs git branch -D

Git rebase pro tips

git reset --soft origin/main
git commit -m "Complete feature implementation"