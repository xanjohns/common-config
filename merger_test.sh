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
# gh repo fork https://github.com/SymbiFlow/prjxray-bram-patch --clone
gh repo fork https://github.com/ryancj14/practice-upstream --clone

echo "Repos cloned"
for dir in ./* ; do
  if [ -d "$dir" ]; then
    dir=${dir%*/}

    LOG_MESSAGE="## Modifications made by common-config"
    FILES_ADDED="### The following files were added:"

    echo "Adding Subtree"
    cd ${dir##*/}
    git checkout -b add-common-config
    git subtree add --prefix third_party/common-config https://github.com/SymbiFlow/symbiflow-common-config.git main --squash

    # git rebase --signoff HEAD~2

    #Make necessary directories
    shopt -s dotglob
    shopt -s extglob
    dirs=`find -type d -path "*third_party/common-config*" -not -path "*assets*"`
    for dir_new in $dirs
    do
      mkdir ${dir_new##*common-config/}
    done
    mkdir -p third_party/common-config/orig

    #Copy old files and replace with common-config
    files=`find -type f -path "*third_party/common-config*" -not -name "merger*" -not -name "README*" -not -name "implementation*" -not -path "*assets*" -not -name "LICENSE"`
    for file in $files
    do
      if [[ -f ${file##*common-config/} ]]; then
        cp ${file##*common-config/} "third_party/common-config/orig/${file##*/}-orig"
        FILES_ADDED="${FILES_ADDED}
[${file##*/}](https://github.com/symbiflow/symbiflow-common-config/blob/main/${file##*common-config/}) *"
      else
      FILES_ADDED="${FILES_ADDED}
[${file##*/}](https://github.com/symbiflow/symbiflow-common-config/blob/main/${file##*common-config/})"
      fi
        filedir="$(dirname $file)"
        mv $file .${filedir##*common-config}
    done

    #Remove all files in common-config execpt orig  directory
    cd third_party/common-config
    rm -rf !(orig*)
    cd ../..

    #Concatenate log message to use in PR description
    LOG_MESSAGE="${LOG_MESSAGE}
${FILES_ADDED}
#### a '*' indicates the file already exists and a backup was created at /third_party/common-config/orig"


    git add .
    git commit -m "Add common-config repo as subtree" --signoff
    git push origin add-common-config
    gh pr create --repo SymbiFlow/${dir##*/} --title "Add common-config repo as subtree" --body "${LOG_MESSAGE}"
    # gh pr create --repo ryancj14/${dir##*/} --title "Add common-config repo as subtree" --body "${LOG_MESSAGE}"
    cd ..
  fi
done
