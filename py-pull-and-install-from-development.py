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
updatedRepoNameArr= []

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
branchName = "development"
if len(sys.argv) == 2:
    script, branchName = argv

print "Pull from: " + branchName + " branch."

# Pull all repos
subp1 = subprocess.Popen(['bash','./helper-git-pull.sh', branchName], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
gitPullstdout , gitPullstderr = subp1.communicate()
print gitPullstdout


# Get repo absolute path
subp2 = subprocess.Popen('find `pwd` -type d -name \".git\"', shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
findstdout , findstderr = subp2.communicate()
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


# Find repos just got updated
repoStatusTemp=str(gitPullstdout).split("\n--------\n")
for r in repoStatusTemp:
    if(r):
        thisRepo = localRepos.get(r.split("\n==>")[0].split("/")[-1])
        thisRepo.gitStatus = r.split("\n==>")[1]
        if(thisRepo.gitStatus!="Already up-to-date."):
            updatedRepoNameArr.append(thisRepo.repoName)


# Find affected repos
affectedRepoNameArr = []
queue = deque(updatedRepoNameArr)
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

for r in updatedRepoNameArr:
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
        shutil.rmtree('node_modules', True)
        if(os.path.exists("package.json")):
            call(['npm install'], shell=True)
        if(temp not in installedRepoNameArr):
            installedRepoNameArr.append(temp)
        os.chdir(rootPath)
    installedRepoNameArr.sort()
    # print installedRepoNameArr

if(len(installedRepoNameArr)==0):
    print "Everything is up-to-date."
else:
    print installedRepoNameArr
    print "Update finished."