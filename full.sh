#!/bin/dash
#
# e.hernandez - 2016
# first attempt at implementing full-screen windows

ARGS=$@

PANEL=15
GAP=25

FSFILE=/tmp/nowm/full

BW=$(wattr b $WID)

ROOT=$(lsw -r)
SW=$(wattr w $ROOT)
SH=$(wattr h $ROOT)

SH=$((SH - PANEL))

WW=$((SW - 2*GAP - 2*BW))
WH=$((SH - 2*GAP - 2*BW - PANEL))

usage() {
	echo "usage: $(basename $0) <wid>" >&2
	exit 1
}

full() {
	echo $1
	wattr xywhi $1 > $FSFILE
	wtp $GAP $((GAP + PANEL)) $WW $WH $1
}

restore() {
	# 10 points if you rm cat w/out breaking
	wtp `cat $FSFILE`
	rm -f $FSFILE
}

main () {
	if [ -f $FSFILE ] ; then
		FSID=$(awk '{print $NF}' $FSFILE)
		if [ $FSID = $1 ] ; then
			restore
		else
			restore
			full $1
		fi
	else
		full $1
	fi
}

main $ARGS
