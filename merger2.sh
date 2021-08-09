#!/bin/bash
#
# Copyright (C) 2020  The SymbiFlow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier:	ISC

mkdir tmp-clone
cd tmp-clone

read -p "This will create many pull requests. Are you sure you want to continue? (y/n) "  -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  kill -INT $$
fi


echo "Clone repos"
gh repo fork https://github.com/xanjohns/upgraded-dollop.git --clone

echo "Repos cloned"
for dir in ./* ; do
  if [ -d "$dir" ]; then
    dir=${dir%*/}

    echo "Adding Subtree"
    cd ${dir##*/}
    git checkout -b add-common-config
    git subtree add --prefix third_party/common-config https://github.com/xanjohns/common-config.git sphinx-feature --squash

    #Make necessary directories
    shopt -s dotglob
    dirs=`find -type d -path "*third_party/common-config*" -not -path "./.git/*" -not -path "./.git"`
    for dir in $dirs
    do
      mkdir ${dir##*common-config/}
    done
    mkdir orig

    #Copy old files and replace with common-config
    files=`find -type f -path "*third_party/common-config*" -not -name "merger*" -not -path "./.git/*"`
    for file in $files
    do
      [[ -f ${file##*common-config/} ]] && mv ${file##*common-config/} "orig/${file##*/}-orig"
      ln $file .${file##*common-config}
    done

    cd ..
  fi
done
