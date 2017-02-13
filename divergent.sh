#!/bin/bash
# Update all git directories below current directory or specified directory
# Skips directories that contain a file called .ignore

HIGHLIGHT="\e[01;34m"
NORMAL='\e[00m'

function update {
  local d="$1"
  if [ -d "$d" ]; then
    if [ -e "$d/.ignore" ]; then
      echo -e "\n${HIGHLIGHT}Ignoring $d${NORMAL}"
    else
      cd $d > /dev/null
      if [ -d ".git" ]; then
        echo -e "\n${HIGHLIGHT}Status Check `pwd`$NORMAL"
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
      else
        scan *
      fi
      cd .. > /dev/null
    fi
  fi
  #echo "Exiting update: pwd=`pwd`"
}

function scan {
  #echo "`pwd`"
  for x in $*; do
    update "$x"
  done
}

if [ "$1" != "" ]; then cd $1 > /dev/null; fi
echo -e "${HIGHLIGHT}Scanning ${PWD}${NORMAL}"
scan *
