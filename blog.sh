#!/bin/bash

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

# clean cache
hexo clean
# generate static files
hexo g
