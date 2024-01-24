#!/bin/bash

if [ $# -le 0 ]
then
	echo Usage mode:
	echo
	echo "	"$0" <file lln> [file lln ...]"
	exit 1
fi

for i in $*
do
	len=${#i}
	q=$(($len - 8))
	p=$(echo ${i:$q:4} | tr "[:lower:]" "[:upper:]")
	awk -f convertInstances.awk $i > $p.ins
done

