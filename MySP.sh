#!/bin/sh
darinst=`dpkg -s clips |grep Status | awk '{ print $4 }'`;
if [ "$darinst" != "installed" ];
then
	sudo apt-get install clips
fi

clips -f "loader.clp";
