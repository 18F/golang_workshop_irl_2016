## goup.sh

This is a one-time setup script for Go.
*Currently only works for Mac OS X.*

Run `./goup.sh && source $HOME/.gvm/scripts/gvm`

- Installs [gvm](https://github.com/moovweb/gvm)
- Installs the stable version of Go.
- Installs [Visual Studio Code](https://code.visualstudio.com/)


## godown.sh

This is a one-time teardown script for Go.
*Currently only works for Mac OS X.*

Run `./godown.sh` to uninstall just gvm and all Go versions installed via gvm.
Run `./godown.sh -a` to uninstall just gvm, all Go versions installed via gvm, AND Visual Studio Code.

## goprojectup.sh

*Currently only works for Mac OS X.*
Must only be used once you have manually set your GOPATH (and not use the global one).

- Installs all the tools for the editor
- Starts Visual Studio Code

## FAQs

### Why Visual Studio Code?

There are many choices for editing Go code. Vim is really big in the community but not everyone uses / knows Vim. Atom would have been used but it doesn't support the debugger at the moment. IntelliJ is also really good and it supports the debugger and more. However, it's a heavyweight IDE and the interface can be confusing with all the options for newcomers. Visual Studio Code has a nice balance of features and simplicity.
