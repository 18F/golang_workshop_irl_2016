#!/bin/bash

if ! [ -x "$(command -v $GOPATH/bin/dlv)" ]; then
	echo -e "Installing delve"
	#Get updated versions from https://bintray.com/jetbrains/golang/delve/view#files/com/jetbrains/delve
	ZIP_FILE=delve.zip
	DOWLOAD_FOLDER=delve
	wget -O $ZIP_FILE https://bintray.com/jetbrains/golang/download_file?file_path=com%2Fjetbrains%2Fdelve%2F0.10.231%2Fdelve-0.10.231.zip
	unzip -o $ZIP_FILE -d $DOWLOAD_FOLDER
	mkdir -p $GOPATH/bin/
	cp $DOWLOAD_FOLDER/dlv/mac/dlv $GOPATH/bin/
	rm $ZIP_FILE
	rm -rf $DOWLOAD_FOLDER
fi

atom $(dirname $0)/../
