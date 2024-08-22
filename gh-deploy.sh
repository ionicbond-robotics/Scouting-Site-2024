#!/bin/bash

REPO_URL = $(git remote get-url origin)
flutter build web --web-renderer html

cd build/web

git init
git add .
git commit -m "GitHub Pages Deploy"
git branch -m ghpages
git remote add origin $REPO_URL
git push -u origin ghpages --force
