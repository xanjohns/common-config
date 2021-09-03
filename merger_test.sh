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
# curl -s https://api.github.com/orgs/SymbiFlow/repos?per_page=200 | python ../merger_help.py
gh repo fork https://github.com/SymbiFlow/prjxray --clone

echo "Repos cloned"
for dir in ./* ; do
  if [ -d "$dir" ]; then
    dir=${dir%*/}

    LOG_MESSAGE="MODIFICATIONS MADE BY COMMON-CONFIG"
    FILES_ADDED="THESE FILES WERE ADDED TO THE TARGET REPO\n"
    FILES_MOVED="THESE FILES ALREADY EXISTED IN TARGET REPO\n"

    echo "Adding Subtree"
    cd ${dir##*/}
    git checkout -b add-common-config
    git subtree add --prefix third_party/common-config https://github.com/SymbiFlow/symbiflow-common-config.git main --squash

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
      if [[ -f ${file##*common-config/} ]]; then
        cp ${file##*common-config/} "orig/${file##*/}-orig"
        FILES_MOVED="${FILES_MOVED}${file} was moved to orig/${file##*/}--orig\n"
      else
        FILES_ADDED="${FILES_ADDED}${file}\n"
      fi
        filedir="$(dirname $file)"
        mv $file .${filedir##*common-config}
    done

    LOG_MESSAGE="${LOG_MESSAGE}\n\n${FILES_ADDED}\n\n${FILES_MOVED}"
    echo -e "${LOG_MESSAGE}"

    # git add .
    # git commit -m "Add common-config repo as subtree"
    # git push
    # gh pr create --repo Symbiflow/${dir##*/} --title "Add common-config repo as subtree" --body "Add common-config repo as subtree under third_party directory. Files are also copied to their required locations in docs, .github, etc."
    cd ..
  fi
done
