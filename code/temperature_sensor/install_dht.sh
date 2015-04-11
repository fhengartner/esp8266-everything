#!/bin/bash

#http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

LUATOOL=${DIR}/../../lib/luatool/luatool/luatool.py
SCRIPT_DIR=${DIR}/dht11/

install() {
	if [ ! -f "${1}" ]; then
		echo "'${1}' does not exist!"
		exit 1
	fi
	
	$LUATOOL --port /dev/tty.usbserial-A5026Z4L --src $1 --dest $2 --verbose
}

pushd $SCRIPT_DIR

for i in dht11.lua readdht.lua senddata.lua init.lua; do
	install $i $i
done