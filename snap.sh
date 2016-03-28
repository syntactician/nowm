#!/bin/sh
# 
# e.hernandez
# implement at least Spectacle functionality under wmutils

ARGS=$@
FSFILE=/tmp/nowm/full

usage() {
	echo "usage: $(basename $0) <direction> <wid>" >&2
	exit 1
}

snapNorth() {
	wtp $FX $FY $FW $HH $1
}

snapEast() {
	wtp $HX $FY $HW $FH $1
}

snapSouth() {
	wtp $FX $HY $FW $HH $1
}

snapWest() {
	wtp $FX $FY $HW $FH $1
}

snapNE() {
	wtp $HX $FY $HW $HH $1
}

snapSE() {
	wtp $HX $HY $HW $HH $1
}

snapSW() {
	wtp $FX $HY $HW $HH $1
}

snapNW() {
	wtp $FX $FY $HW $HH $1
}

snapCenter() {
	CW=$(wattr w $1)
	CH=$(wattr h $1)

	wtp $((SW/2 - CW/2 - BW))         \
		$((SH/2 - CH/2 - BW + PANEL)) \
		$CW                           \
		$CH                           \
		$1
}

fullscreen() {
	wattr xywhi $1 > $FSFILE
	wtp $FX $FY $FW $FH $1
}

restorefull() {
	wtp $(< $FSFILE)
	rm -f $FSFILE
}

snapFull() {
	if [ -f $FSFILE ] ; then
		FSID=$(awk '{print $NF}' $FSFILE)
		if [ $FSID = $1 ] ; then
			restorefull
		else
			restorefull
			fullscreen $1
		fi
	else
		fullscreen $1
	fi
}

main() {
	. ~/.wm/dimensions.sh
	
	case $1 in
		h|west|left)     snapWest   $2 ;;
		j|south|down)    snapSouth  $2 ;;
		k|north|up)      snapNorth  $2 ;;
		l|east|right)    snapEast   $2 ;;
		tr|ne|northeast) snapNE     $2 ;;
		br|se|southeast) snapSE     $2 ;;
		bl|sw|southwest) snapSW     $2 ;;
		tl|nw|northwest) snapNW     $2 ;;
		center)          snapCenter $2 ;;
		full)            snapFull   $2 ;;
		*)               usage         ;;
	esac
}

main $ARGS
