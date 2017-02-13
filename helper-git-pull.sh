#!/bin/bash

BRANCH=$1

if [ $# -eq 0 ]
    then
        echo "Missing branchName. You can't continue."
        exit 1
fi

LOCAL_REPOS=`find . -name ".git"|cut -d "/" -f 2`
# echo $LOCAL_REPOS

REPO_ROOT=`pwd`

for REPO in ${LOCAL_REPOS} ;do
    cd ${REPO}
    echo "$REPO"
    pullCommand=`git pull origin $BRANCH`
    echo -e "==>$pullCommand\n--------"
    cd ${REPO_ROOT}
done
cd ${REPO_ROOT}
