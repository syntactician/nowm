#!/bin/sh
# 
# e.hernandez
# implement at least Spectacle functionality under wmutils

ARGS=$@

PANEL=15
GAP=25

FSFILE=/tmp/nowm/full

WID=$2
DWW=$(wattr b $WID)

ROOT=$(lsw -r)
SW=$(wattr w $ROOT)
SH=$(wattr h $ROOT)

SH=$((SH - PANEL))

WW=$((SW - 2*BW - 2*GAP))
WH=$((SH - 2*BW - 2*GAP))

HW=$((SW/2 - GAP - GAP/2 - 2*BW))
HH=$((SH/2 - GAP - GAP/2 - 2*BW))

HX=$((SW/2 + GAP/2))
HY=$((SH/2 + GAP/2 + PANEL))

usage() {
	echo "usage: $(basename $0) <direction> <wid>" >&2
	exit 1
}

snapNorth() {
	wtp $GAP $((GAP + PANEL)) $WW $HH $1
}

snapEast() {
	wtp $HX $((GAP + PANEL)) $HW $WH $1
}

snapSouth() {
	wtp $GAP $HY $WW $HH $1
}

snapWest() {
	wtp $GAP $((GAP + PANEL)) $HW $WH $1
}

snapNE() {
	wtp $HX $((GAP + PANEL)) $HW $HH $1
}

snapSE() {
	wtp $HX $HY $HW $HH $1
}

snapSW() {
	wtp $GAP $HY $HW $HH $1
}

snapNW() {
	wtp $GAP $((GAP + PANEL)) $HW $HH $1
}

snapCenter() {
	wtp $((SW/2 - WW/2 - BW))         \
		$((SH/2 + PANEL - WH/2 - BW)) \
		$(wattr w $1)                 \
		$(wattr h $1)                 \
		$1
}

fullscreen() {
	wattr xywhi $1 > $FSFILE
	wtp $GAP $((GAP + PANEL)) $WW $WH $1
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
