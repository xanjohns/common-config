#!/bin/bash



mkdir tmp-clone
cd tmp-clone

read -p "This will create many pull requests. Are you sure you want to continue? (y/n) "  -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  kill -INT $$
fi


echo "Clone repos"
curl -s https://api.github.com/orgs/SymbiFlow/repos?per_page=200 | python ../merger_help.py 

echo "Repos cloned"
for dir in ./* ; do
  if [ -d "$dir" ]; then
    dir=${dir%*/}

    echo "Adding Subtree"
    cd ${dir##*/}
    git checkout -b add-common-config
    git subtree add --prefix third_party/common-config https://github.com/SymbiFlow/common-config.git main --squash

    shopt -s dotglob
    mv third_party/common-config/formatter-files/* .
    mv third_party/common-config/LICENSE .
    mv third_party/common-config/docs/* ./docs
    mv third_party/common-config/.github/ISSUE_TEMPLATE/* ./.github/ISSUE_TEMPLATE
    mv third_party/common-config/.github/workflows/* ./.github/workflows
    mv third_party/common-config/.github/pull_request_template.md ./.github
    git add .
    git commit -m "Add common-config repo as subtree"
    git push
    gh pr create --repo Symbiflow/${dir##*/} --title "Add common-config repo as subtree" --body "Add common-config repo as subtree under third_party directory. Files are also copied to their required locations in docs, .github, etc."
    cd ..
  fi
done
