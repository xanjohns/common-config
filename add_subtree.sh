#!/bin/bash
#
# Copyright (C) 2020  The SymbiFlow Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier:	ISC

# Create temporary directory to store cloned repos
mkdir tmp-clone
cd tmp-clone

read -p "Enter GitHub username (used for pull request creation):" userID
read -p "Enter the url of the repository that common-config will be merged into (Leave blank to clone all SymbiFlow repositories):" userURL
read -p "Enter the name of the feature set to be added/updated:" FEATURE_SET
if [ $userURL ]; then
  gh repo fork $userURL --clone
else
  read -p "This will create many pull requests. Are you sure you want to continue? (y/n) "  -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
  kill -INT $$
  fi
  echo "Clone repos"
  python <<EOF
import urllib.request
import json;
import os;
with urllib.request.urlopen('https://api.github.com/orgs/SymbiFlow/repos?per_page=200') as response:
  json_arr = json.loads(response.read())
  for val in json_arr:
    if val['fork'] == False:
      url = val['clone_url']
      os.system("gh repo fork {} --clone".format(url))
EOF
fi



echo "Repo cloned"
for dir in ./* ; do
  if [ -d "$dir" ]; then
    dir=${dir%*/}

    LOG_MESSAGE="## Modifications made by common-config"
    FILES_ADDED="### Files now present from common-config:"

    echo "Adding Subtree"
    cd ${dir##*/}
    git checkout -b add-common-config
    git subtree add --prefix third_party/common-config https://github.com/SymbiFlow/symbiflow-common-config.git main --squash

    # Merge two commits that come from subtree and add DCO signoff
    git reset --soft HEAD~1 && git commit -m "Add common-config as a subtree"
    git commit --amend --no-edit --signoff

    #Make necessary directories
    shopt -s dotglob
    shopt -s extglob
    dirs=`find -type d -path "*third_party/common-config*" -not -path "*assets*"`
    for dir_new in $dirs
    do
      mkdir ${dir_new##*common-config/}
    done

    #Copy old files and replace with common-config
    files=`find -type f -path "*third_party/common-config*" -not -name "merger*" -not -name "README*" -not -name "implementation*" -not -path "*assets*" -not -name "LICENSE"`
    for file in $files
    do
      FILES_ADDED="${FILES_ADDED}
[${file##*/}](https://github.com/symbiflow/symbiflow-common-config/blob/main/${file##*common-config/})"
      if [[ -f ${file##*common-config/} ]]; then
        if ! cmp -s $file ${file##*common-config/}; then
        FILES_ADDED="${FILES_ADDED}(Updated)"
        filedir="$(dirname $file)"
        mv $file .${filedir##*common-config}
        fi
      else
      FILES_ADDED="${FILES_ADDED}(New)"
      filedir="$(dirname $file)"
      mv $file .${filedir##*common-config}
      fi
    done

    #Remove all files in common-config execpt orig  directory
    cd third_party/common-config
    rm -rf !(orig*)
    cd ../..

    #Concatenate log message to use in PR description
    LOG_MESSAGE="${LOG_MESSAGE}
${FILES_ADDED}"

    git add .
    git commit -m "Move files to correct locations" --signoff
    git push origin add-common-config
    gh pr create --repo SymbiFlow/${dir##*/} --title "Common-config: [${FEATURE_SET}]" --head $userID:add-common-config --body "${LOG_MESSAGE}"
    cd ..
  fi
done
