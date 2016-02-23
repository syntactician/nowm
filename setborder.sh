#!/bin/dash
# set or unset border

ARGS="$@"

usage() {
	echo "Usage: $(basename $0) <state> <wid>"
	test -z $1 || exit 1
}

pulse() {
	# pulse UNTIL focused
	i=1
	while [ "$1" != "$(pfw)" ] ; do

		if [ $(echo "$i % 2" | bc) -eq 1 ] ; then
			chwb -c $WARN $1
		else
			chwb -c $BG $1
		fi

		i=$((i + 1))
		sleep 1

	done
}

batteryWarning() {
	BC="$bc0 $bc1 $bc2 $bc3 $bc4 $bc5"

	while true; do
		if [ $(battery) -lt 5 ] ; then
			chwb -c $bc0 $(pfw)
			sleep 1
			chwb -c $BG $(pfw)
			sleep 1
		elif [ $(battery) -lt 10 ] ; then
			for C in $BC; do
				chwb -c $C $(pfw)
				sleep 1
			done
		else
			continue
		fi
	done
}

main() {
	. ~/.wm/shared.sh

	test -z $1 && usage 1

	wattr "$2" && {
		case $1 in
			none)     chwb -s 0            $2 ;;
			active)   chwb -s $BW -c $FG   $2 ;;
			inactive) chwb -s $BW -c $BG   $2 ;;
			warning)  chwb -s $BW -c $WARN $2 ;;
			pulse)    pulse $2                ;;
			battery)  batteryWarning $2       ;;
			*)        usage 0 ;;
		esac
	} || {
		echo "You have not entered a window id." >&2
	}
}

main $ARGS
