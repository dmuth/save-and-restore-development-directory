#!/bin/bash
#
# This script will go through a directory, get the 
# remote called "origin" for every Git repo, and then print
# out all directory and remove information, so that the 
# entire directory structure can be recreated on another computer.
#


# Errors are fatal
set -e

if test ! "$1"
then
	echo "! "
	echo "! Syntax: $0 directory"
	echo "! "
	echo "! directory - Top-level directory to get Git remotes from. "
	echo "! 	There can be as much nesting as you like. :-)"
	echo "! "
	exit 1
fi

SRC=$1

pushd $SRC > /dev/null

for DIR in $(find . -name .git -type d)
do
	#
	# Get the name of the directory over the .git directory
	#
	DIR=$(dirname $DIR)

	#
	# Drop into that directory, get the remove, and jump back out!
	#
	pushd $DIR > /dev/null
	REMOTE=$(git remote -v | head -n1 | awk '{print $2}')
	popd > /dev/null

	#
	# Skip anything without a remove
	#
	if test ! "$REMOTE"
	then
		continue
	fi

	echo -e "${DIR}\t${REMOTE}"

done


# All done!



