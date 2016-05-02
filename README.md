# 2016 IRL Golang Workshop

This repository contains workshop material for the 2016 18F IRL Golang Workshop

For the Table of Contents, refer to [here](chapters/README.md)

## One Time Setup
```
# change your directory into where ever you normally store your code
# Create a Go workspace.
mkdir golang_workshop_ws
cd golang_workshop_ws

# clone the repo into the correct location of the workspace
git clone https://github.com/18F/golang_workshop_irl_2016.git src/github.com/18F/golang_workshop_irl_2016

# run the setup script
src/github.com/18F/golang_workshop_irl_2016/scripts/goup.sh && source $HOME/.gvm/scripts/gvm
```

## Let's Start Everything Up!
```
# use this section of commands every time you want to start / resume this tutorial

# make sure you are in your workspace.
# establish go workspace formally
export GOPATH=$(pwd)

# change directory into the location of the cloned repo
cd src/github.com/18F/golang_workshop_irl_2016/

# start the ide and download / update tools
scripts/goprojectup.sh
```

## Getting Started
If these steps look a little foreign, it's a great time to dive into [chapter 01](chapters/ch01/README.md)

## Oh no, I don't want this on my computer anymore.
```
# to remove just Go related stuff:
scripts/godown.sh
# to remove just Go related stuff and the IDE:
scripts/godown.sh -a
```
