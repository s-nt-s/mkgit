#!/bin/bash
read -p "User: " -e -i "$(git config --global user.name)" USER
if [ -z "$USER" ]; then
	echo "User is required"
	exit 1
fi
read -s -p "Password: " PASS
echo ""
if [ -z "$PASS" ]; then
	echo "Password is required"
	exit 1
fi

read -p "Name: " -e -i "${PWD##*/}" REPO
read -p "Description: " -e -i "$(head -n 1 README.md 2> /dev/null)" DESCRIPTION

OK=$(curl -w "%{http_code}" -o /dev/null -s -u "$USER:$PASS" https://api.github.com)

if [ "$OK" -ne "200" ]; then
	echo "Login error: $OK"
	exit 1
fi

curl -s -u "$USER:$PASS" https://api.github.com/user/repos -d "{\"name\": \"$REPO\", \"description\": \"$DESCRIPTION\"}"

git init

git add *
git commit -m "First commit"
git remote add origin https://github.com/${USER}/${REPO}.git
git push --set-upstream origin master

if [ "$1" != "--nopush" ]; then
	#git remote add origin git@github.com:${USER}/${REPO}.git
	git push -u origin master
fi

