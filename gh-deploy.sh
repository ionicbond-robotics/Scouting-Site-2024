#!/bin/bash

REPO_URL=$(git remote get-url origin)
flutter build web --web-renderer html

cd build/web

sed -i '/<base href="\/">/d' index.html # Comment this line if u need the base href specified

git init
git add .
git commit -m "GitHub Pages Deploy"
git branch -M ghpages
git remote add origin $REPO_URL
git push -u origin ghpages --force
