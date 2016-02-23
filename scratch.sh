
#!/bin/dash
#
# e.hernandez - 2016
# store a window unmapped for easy access

# depends on focus.sh
# optionally depends on focus.sh

if [ -f .sw ] ; then
	wid=$(<~/.wm/.sw)
	chwso -r $wid
	mapw -m $wid
	./focus.sh $wid
	rm -f .sw
else
	wid=$(pfw)
	wattr i $wid >~/.wm/.sw
	mapw -u $wid
	sleep 1
	./focus.sh next
fi
