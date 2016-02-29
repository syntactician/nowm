
#!/bin/dash
# e.hernandez
# 
# store a single window unmapped but accessible
# depends on focus.sh
# /tmp/nowm/ must exist for this script to behave properly

SCFILE=/tmp/nowm/scratch

if [ -f $SCFILE ] ; then
	wid=$(< $SCFILE)
	chwso -r $wid
	mapw -m $wid
	focus.sh $wid
	rm -f $SCFILE
else
	WID=$(pfw | tee $SCFILE)
	mapw -u $WID
fi
