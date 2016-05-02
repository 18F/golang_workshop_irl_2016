#!/bin/bash

# Usage info
show_help() {
cat << EOF
Usage: ${0##*/} [-ha]
Clean up go installation and optionally 3rd party apps. Default is just GVM

    -h          display this help and exit
    -a          remove gvm AND Visual Studio Code.
    		Useful if you don't plan on using Visual Studio Code.
EOF
}
OPTIND=1
all=0
while getopts "ha" opt; do
    case "$opt" in
        h)
            show_help
            exit 0
            ;;
        a)  all=$((all+1))
            ;;
        '?')
            show_help >&2
            exit 1
            ;;
    esac
done
shift "$((OPTIND-1))" # Shift off the options and optional --.

source $GVM_ROOT/scripts/gvm
yes | gvm implode
if [ $all == 1 ]; then
	echo -e "Removing Visual Studio Code"
	VSCODE_APP_NAME=Visual\ Studio\ Code.app
	rm -rf /Applications/"${VSCODE_APP_NAME}"
fi

