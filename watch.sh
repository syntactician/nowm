#!/bin/sh
#
# ez - 2016
# handle automatic window focus
# depends on: wew focus.sh

while IFS=: read ev wid; do
    case $ev in
        # focus new windows
        19) wattr o $wid || focus.sh $wid ;;

		# defocus killed windows
		18) wattr "$(pfw)" || focus.sh prev ;;
	
		# also focus on mouse
		# 7) wattr o $wid || focus.sh $wid ;;
    esac
done
