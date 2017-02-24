#!/usr/bin/python

import subprocess
import json
import os
import sys
import string
from sys import argv
from subprocess import call
from collections import deque
import shutil

# cdspRepoNameArr=[u'discovery-model', u'discovery-service', u'discovery-proxy', u'tenant-model', u'discovery-client', u'tenant-service', u'core-server', u'mdn-service', u'location-service', u'payment-service', u'security-service', u'platform-seed', u'multi-tenancy-db', u'generator-service-gen', u'security-model', u'core-worker', u'security-middleware', u'discovery-middleware', u'stash', u'mdn-email-worker', u'mdn-sms-worker']
cdspRepoNameArr= []
changedReops = []

installedRepoNameArr = []
installationQueue = deque([])

class repoClass:
    def __init__(self, thisRepoName, thisGitStatus, thisDependencies, thisDependedBy, thisPath):
        self.repoName = thisRepoName
        self.gitStatus = thisGitStatus
        self.dependencies = thisDependencies
        self.dependedBy = thisDependedBy
        self.path = thisPath

rootPath = os.getcwd()


# Get all cdsp repos
subp0 = subprocess.Popen(['curl', '-s', "https://api.github.com/orgs/monsterstack/repos"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
curlstdout , curlstderr = subp0.communicate()
op = json.loads(curlstdout)
for repo in op:
    cdspRepoNameArr.append(repo["name"])


# Starts
script = ""
changedReopsStr = ""
if len(sys.argv) == 2:
    script, changedReopsStr = argv
else:
    print "Please type the repo that you made change locally, you can seperate repos using comma."
    print "Example: python py-local-install.py discovery-middleware"
    print "Example: python py-local-install.py discovery-middleware,core-server"
    sys.exit(0)
changedReops = changedReopsStr.split(",")


# Get repo absolute path
subp1 = subprocess.Popen('find `pwd` -type d -name \".git\"', shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
findstdout , findstderr = subp1.communicate()
localReposPath = findstdout.split(".git\n")[:-1]


# Get local git repos and its dependencies and absolute path
localRepos = {}
localReposNameArr = []
basicRepos = []
for thisPath in localReposPath:
    folder = thisPath.split("/")[-2]
    os.chdir(thisPath)
    if (os.path.isdir(".git")):
        thisDependencies = []
        if(os.path.exists("package.json")):
            thisPackageJson = json.loads(open("package.json").read())
        else:
            thisDependencies = []
            thisPackageJson["dependencies"] = []
        for dependency in thisPackageJson["dependencies"]:
            if dependency in cdspRepoNameArr:
                thisDependencies.append(dependency)
        localRepos[folder] = repoClass(folder, None, thisDependencies, [], thisPath)
        if (len(thisDependencies)==0):
            basicRepos.append(folder)
        localReposNameArr.append(folder)
    os.chdir(rootPath)


# Find affected repos
affectedRepoNameArr = []
queue = deque(changedReops)
while(len(queue)!= 0):
    thisAffectedRepoName = queue.popleft()
    for theRepoName, theRepoInfo in localRepos.iteritems():
        if (len(theRepoInfo.dependencies)!=0) and (thisAffectedRepoName in theRepoInfo.dependencies):
            # print thisAffectedRepoName
            # print "DependedBy:" + theRepoName
            if theRepoName not in localRepos.get(thisAffectedRepoName).dependedBy:
                localRepos.get(thisAffectedRepoName).dependedBy.append(theRepoName)
            if theRepoName not in affectedRepoNameArr:
                affectedRepoNameArr.append(theRepoName)
            queue.append(theRepoName)

for r in changedReops:
    if list((set(localRepos.get(r).dependencies) & set(affectedRepoNameArr)))==[]:
        installationQueue.append(r)
for r in installationQueue:
    if r not in affectedRepoNameArr:
        affectedRepoNameArr.append(r)
affectedRepoNameArr.sort()
# print affectedRepoNameArr


# Install
while (affectedRepoNameArr != installedRepoNameArr):
    for theRepoName, theRepoInfo in localRepos.iteritems():
        #get affected dependencies
        affectedDependencies = []
        for repo in affectedRepoNameArr:
            if repo in theRepoInfo.dependencies:
                affectedDependencies.append(repo)
        if (len(theRepoInfo.dependencies)!=0) and set(affectedDependencies)<=set(installedRepoNameArr):
            if (theRepoName not in installationQueue) and (theRepoName not in installedRepoNameArr) and (theRepoName in affectedRepoNameArr):
                installationQueue.append(theRepoName)

    while (len(installationQueue)!=0):
        temp = installationQueue.popleft()
        os.chdir(localRepos.get(temp).path)
        print temp

        if (os.path.exists('node_modules')==False):
            call(['npm install > /dev/null'], shell=True)
        if (temp in changedReops):
            # print "!!!"
            shutil.rmtree('node_modules', True)
            call(['npm install > /dev/null'], shell=True)

        os.chdir("node_modules")
        for dependency in installedRepoNameArr:
            if (dependency in localRepos.get(temp).dependencies):
                shutil.rmtree(dependency, True)
                call(["rsync -a --exclude='.git' "+localRepos.get(dependency).path[:-1]+" ./"], shell=True)
        os.chdir("..")

        if(temp not in installedRepoNameArr):
            installedRepoNameArr.append(temp)
        os.chdir(rootPath)
    installedRepoNameArr.sort()
    # print installedRepoNameArr

if(len(installedRepoNameArr)==0):
    print ">>>Nothing to install<<<"
else:
    print installedRepoNameArr
    print ">>>Update finished<<<"