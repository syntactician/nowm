#!/bin/sh
# e.hernandez
# 
# stows current window unmapped OR retrieves stowed  window
#
# depends on focus.sh
# /tmp/nowm/ must exist for this script to behave properly

SCFILE=/tmp/nowm/scratch

stow(){
	WID=$(echo "$1" | tee $SCFILE)
	mapw -u $WID
}

retrieve(){
	WID=$(< $SCFILE)
	chwso -r $WID
	mapw -m $WID
	focus.sh $WID
	rm -f $SCFILE
}

main(){
	if [ -f $SCFILE ] ; then
		retrieve
	else
		stow $(pfw)
	fi
}


main
