#!/bin/bash

npm install hexo-cli -g

cd zh
npm install --force

hexo clean
hexo g
