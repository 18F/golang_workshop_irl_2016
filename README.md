# 2016 IRL Golang Workshop

This repository contains workshop material for the 2016 18F IRL Golang Workshop

## Setup
```
# change your directory into where ever you normally store your code
# Create a Go workspace.
mkdir golang_workshop_ws
cd golang_workshop_ws

# clone the repo into the correct location of the workspace
git clone https://github.com/jcscottiii/golang_workshop.git src/github.com/jcscottiii/golang_workshop

# run the setup script
src/github.com/jcscottiii/golang_workshop/scripts/goup.sh && source $HOME/.gvm/scripts/gvm

# establish go workspace formally
export GOPATH=$(pwd)

# change directory into the location of the cloned repo
cd src/github.com/jcscottiii/golang_workshop/

# start the ide and download tools
scripts/goprojectup.sh
```

If these steps look a little foriegn, it's a great time to dive into [chapter 01](chapters/ch01/README.md)
