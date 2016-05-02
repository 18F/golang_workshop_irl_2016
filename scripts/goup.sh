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

# Install the IDE
# You can get the link by downloading the file in Chrome from http://code.visualstudio.com/
# Then go to the downloads view "chrome://downloads/.
# You should see the url for the downloaded file.
APP_NAME=Atom.app
ls /Applications/"${APP_NAME}" >/dev/null 2>&1
if [ $? != 0 ]; then
	ZIP_FILE=atom.zip
	DOWLOAD_FOLDER=atom
	APP_SRC=$DOWLOAD_FOLDER/$APP_NAME
	echo -e "Installing IDE"
	exit_on_fail wget -O $ZIP_FILE https://atom-installer.github.com/v1.7.3/atom-mac.zip
	exit_on_fail unzip -o $ZIP_FILE -d $DOWLOAD_FOLDER
	exit_on_fail cp -R "${APP_SRC}" "/Applications/"
	exit_on_fail rm -rf $DOWLOAD_FOLDER
	exit_on_fail rm $ZIP_FILE
	echo -e "Cleaning up IDE Install"
fi

echo -e "IDE Installed\n"

exit_on_fail apm install go-plus
exit_on_fail apm enable go-plus
exit_on_fail apm install go-debug
exit_on_fail apm enable go-debug

echo -e "Success!"
echo -e "Run 'source $GVM_ROOT/scripts/gvm'"
