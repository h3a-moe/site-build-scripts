#!/bin/bash

# get full commit history
git fetch --unshallow

# get PGP key
wget https://github.com/h3arn.gpg 
git config --global gpg.program gpg2
gpg2 --import h3arn.gpg

# Dependency: hexo-cli
npm install hexo-cli -g

# change workdir
cd zh
# install dependencies
npm install --force

# remove outdated link.yml
if test -f "./source/_data/link.yml"; then
    rm ./source/_data/link.yml
fi
# generate friend link yaml file
cat ./source/_data/*.yml > ./source/_data/link.yml

# generate /history page
mkdir -p source/history
touch source/history/index.md 
cat << EOT > source/history/index.md 
---
title: History
---
<div class="markdown-body">
<h1>Commit History</h1>
EOT
echo '```' >> source/history/index.md 
git log --show-signature >> source/history/index.md 
echo '```' >> source/history/index.md 
echo '</div>' >> source/history/index.md

# clean cache
hexo clean
# generate static files
hexo g
