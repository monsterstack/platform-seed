#!/bin/bash

REPOS=`find . -name ".git"|cut -d "/" -f 2`
REPO_ROOT=`pwd`

if [ -z $1 ] ; then
    echo "commit message needed"
    exit 0
fi

for REPO in ${REPOS} ;do
    cd ${REPO}
    git add -A
    git commit -m "$1"
    git push origin "development"
    cd ${REPO_ROOT}
    echo "commited all changes for ${REPO} to development"
done
