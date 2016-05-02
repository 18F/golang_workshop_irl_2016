#!/bin/bash -l

# This will selectively cause some calls to exit in case they fail.
function exit_on_fail {
	set -e
	"$@"
	set +e
}
GVM_ROOT=$HOME/.gvm
GVM=$GVM_ROOT/bin/gvm

if ! [ -x "$(command -v $GVM)" ]; then
	echo -e "Installing GVM"
	exit_on_fail bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
fi
source $GVM_ROOT/scripts/gvm
echo -e "\nGVM Installed"

# Install Go
# First bootstrap
# https://github.com/moovweb/gvm#a-note-on-compiling-go-15
echo -e "\nInstalling Bootstrapping Go (1 of 2)"
exit_on_fail $GVM install go1.4.2 -B

exit_on_fail gvm use go1.4.2
export GOROOT_BOOTSTRAP=$GOROOT
# Install the latest version of Go
echo -e "\nInstalling latest stable version of Go (2 of 2)"
exit_on_fail $GVM install go1.6.2
exit_on_fail gvm use go1.6.2 --default
go version

# Install VSCode
# You can get the link by downloading the file in Chrome from http://code.visualstudio.com/
# Then go to the downloads view "chrome://downloads/.
# You should see the url for the downloaded file.
VSCODE_APP_NAME=Visual\ Studio\ Code.app
ls /Applications/"${VSCODE_APP_NAME}" >/dev/null 2>&1
if [ $? != 0 ]; then
	VSCODE_ZIP=VSCode.zip
	VSCODE_DOWLOAD_FOLDER=vscode
	VSCODE_APP_SRC=$VSCODE_DOWLOAD_FOLDER/$VSCODE_APP_NAME
	echo -e "Installing Visual Studio Code version 1.0.0"
	exit_on_fail wget -O $VSCODE_ZIP https://az764295.vo.msecnd.net/stable/fa6d0f03813dfb9df4589c30121e9fcffa8a8ec8/VSCode-darwin-stable.zip
	exit_on_fail unzip -o $VSCODE_ZIP -d $VSCODE_DOWLOAD_FOLDER
	exit_on_fail cp -R "${VSCODE_APP_SRC}" "/Applications/"
	exit_on_fail rm -rf $VSCODE_DOWLOAD_FOLDER
	exit_on_fail rm $VSCODE_ZIP
	echo -e "Cleaning up Visual Studio Code Install"
fi
echo -e "Visual Studio Code Installed\n"

# Install NVM
if ! [ -x "$(command -v $NVM_DIR/nvm.sh)" ]; then
	echo -e "Installing nvm"
	exit_on_fail curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
	NVM_DIR=$HOME/.nvm
fi
. "$NVM_DIR/nvm.sh"
echo -e "nvm Installed"

nvm install 5.0
nvm use 5.0

npm install -g vsce && git clone https://github.com/Microsoft/vscode-go $HOME/.vscode/extensions/lukehoban.Go && pushd $HOME/.vscode/extensions/lukehoban.Go && npm install && vsce package && popd

echo -e "Success!"
echo -e "Run 'source $GVM_ROOT/scripts/gvm'"
