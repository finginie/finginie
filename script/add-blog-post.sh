#!/bin/bash

git fetch origin
git add .
git reset --hard origin/master

pushd engines/content

git fetch origin
git add .
git reset --hard origin/master

cp -v $1 app/content/blog/_posts/$(date +"%Y-%m-%d")-market-commentary.md

git add .
git commit -m "added market commentary - $(date)"
git push origin HEAD:master

popd

git add engines/content
git commit -m "added market commentary - $(date)"
git push origin HEAD:master
