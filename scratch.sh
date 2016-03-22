#!/bin/sh
# e.hernandez
# 
# store a single window unmapped but accessible
# depends on focus.sh
# /tmp/nowm/ must exist for this script to behave properly

SCFILE=/tmp/nowm/scratch

if [ -f $SCFILE ] ; then
	WID=$(< $SCFILE)
	chwso -r $WID
	mapw -m $WID
	focus.sh $WID
	rm -f $SCFILE
else
	WID=$(pfw | tee $SCFILE)
	mapw -u $WID
fi
