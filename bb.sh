#!/bin/dash
# pulse window border when battery critically low

. ~/.wm/shared.sh

bc="$bc0 $bc1 $bc2 $bc3 $bc4 $bc5"

main() {
	while [ $(battery) -lt 60 ]; do
		for c in $bc; do
			chwb -c $c $(pfw)
			sleep 1
		done
	done
}

main
