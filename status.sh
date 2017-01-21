#!/bin/bash

REPOS=`find . -name ".git"|cut -d "/" -f 2`
REPO_ROOT=`pwd`

for REPO in ${REPOS} ;do
    cd ${REPO}
    echo ${REPO}
    git status
    cd ${REPO_ROOT}
done
