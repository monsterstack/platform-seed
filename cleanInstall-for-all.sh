#!/bin/bash

BRANCH=$1

if [ $# -eq 0 ]
  then
    BRANCH="development"
fi

echo $BRANCH

# CDSP_REPOS=`curl -s https://api.github.com/orgs/monsterstack/repos | ruby -rubygems -e 'require "json"; JSON.load(STDIN.read).each { |repo| puts "#{repo["name"]}" }'`
# echo -e "CDSP_REPOS: \n$CDSP_REPOS"

REPOS=`find \`pwd\` -name ".git"|rev|cut -d "/" -f 2-|rev`
# echo $SERVICE_REPOS


REPO_ROOT=`pwd`


for REPO in ${REPOS}; do
    cd ${REPO}
    # `rm -rf node_modules`
    pullCommand=`git pull origin $BRANCH`
    echo "$pullCommand"
    findPackageJsonCommand=`find . -maxdepth 1 -iname "package.json"`
    if [ "$findPackageJsonCommand" != "" ]
        then
            `rm -rf node_modules`
    fi
    cd ${REPO_ROOT}
done
cd ${REPO_ROOT}
