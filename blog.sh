#!/bin/bash

# get full commit history
git fetch --unshallow

# get PGP key
wget https://github.com/h3arn.gpg 
git config --global gpg.program gpg2
gpg2 --import h3arn.gpg
# set owner trust
echo '364864A3A1AF4174D9BDE7C66076CBBA23E98A57:6:' | gpg2 --import-ownertrust
#gpg --list-keys --fingerprint |grep pub -A 1|egrep -Ev "pub|--"|tr -d ' '|sed 's/Keyfingerprint=//' \
# | awk 'BEGIN { FS = "\n" } ; { print $1":6:" } ' | grep '364864A3A1AF4174D9BDE7C66076CBBA23E98A57:6:' | gpg --import-ownertrust
gpg2 --list-keys
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
