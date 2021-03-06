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

$DIR/flash.sh $DIR/../../lib/nodemcu-firmware/pre_build/0.9.5/nodemcu_20150212.bin

