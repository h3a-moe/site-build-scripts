#!/bin/bash

npm install hexo-cli -g

cd zh
npm install --force

if test -f "./source/_data/link.yml"; then
    rm ./source/_data/link.yml
fi

cat ./source/_data/*.yml > ./source/_data/link.yml

hexo clean
hexo g
