#!/bin/bash
#http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

SERIAL=/dev/tty.usbserial-A5026Z4L
ESPTOOL=$DIR/../../lib/esptool/esptool.py

if [ ! -f "$1" ]; then
	echo "error: file not found '${1}'"
	exit
fi

env python2.7 $ESPTOOL -p $SERIAL write_flash 0x0000 $1
