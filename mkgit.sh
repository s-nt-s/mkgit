#!/bin/bash
repo=${PWD##*/}
git init
git add *
git commit -m "first commit"
git remote add origin https://github.com/santos82/$repo.git
git push -u origin master
