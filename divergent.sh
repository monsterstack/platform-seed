#!/bin/bash

REPOS=`find . -name ".git"|cut -d "/" -f 2`
REPO_ROOT=`pwd`

for REPO in ${REPOS} ;do
    cd ${REPO}

    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse @{u})
    BASE=$(git merge-base @ @{u})

    if [ $LOCAL = $REMOTE ]; then
       echo "Up-to-date => ${REPO}"
    elif [ $LOCAL = $BASE ]; then
       echo "${RED}Need to pull => ${REPO}"
    elif [ $REMOTE = $BASE ]; then
       echo "${RED}Need to push => ${REPO}"
    else
       echo "${RED}Diverged => ${REPO}"
    fi

    cd -

    cd ${REPO_ROOT}
done
