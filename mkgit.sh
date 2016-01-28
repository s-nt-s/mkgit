#!/bin/bash
if [ -f "~/.github" ]; then
	echo "~/.github don't find"
	exit 1
fi
CONFIG=$(cat ~/.github)
USER=$(echo "$CONFIG" | cut -f1 -d' ')
PASS=$(echo "$CONFIG" | cut -f2 -d' ')
TOKEN=$(echo "$CONFIG" | cut -f3 -d' ')
REPO=${PWD##*/}

curl -s -u "$USER:$PASS" https://api.github.com/user/repos -d "{\"name\": \"$REPO\"}"

git init
git add *
git commit -m "first commit"
git remote add origin https://github.com/${USER}/${REPO}.git
git push -u origin master