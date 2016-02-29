#!/bin/sh
# 
# e.hernandez
# implement at least Spectacle functionality under wmutils

ARGS=$@

PANEL=15
GAP=25

WID=$(pfw)
BW=$(wattr b $WID)

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
	echo "usage: $(basename $0) <direction>" >&2
	exit 1
}

snapNorth() {
	wtp $GAP $((GAP + PANEL)) $WW $HH $WID
}

snapEast() {
	wtp $HX $((GAP + PANEL)) $HW $WH $WID
}

snapSouth() {
	wtp $GAP $HY $WW $HH $WID
}

snapWest() {
	wtp $GAP $((GAP + PANEL)) $HW $WH $WID
}

snapNE() {
	wtp $HX $((GAP + PANEL)) $HW $HH $WID
}

snapSE() {
	wtp $HX $HY $HW $HH $WID
}

snapSW() {
	wtp $GAP $HY $HW $HH $WID
}

snapNW() {
	wtp $GAP $((GAP + PANEL)) $HW $HH $WID
}

snapCenter() {
	WW=$(wattr w $WID)
	WH=$(wattr h $WID)

	wtp $((SW/2 - WW/2 - BW)) $((SH/2 + PANEL - WH/2 - BW)) $WW $WH $WID
}

main() {
	case $1 in
		h|west|left)     snapWest   ;;
		j|south|down)    snapSouth  ;;
		k|north|up)      snapNorth  ;;
		l|east|right)    snapEast   ;;
		tr|ne|northeast) snapNE     ;;
		br|se|southeast) snapSE     ;;
		bl|sw|southwest) snapSW     ;;
		tl|nw|northwest) snapNW     ;;
		center)          snapCenter ;;
		*)               usage      ;;
	esac
}

main $ARGS
