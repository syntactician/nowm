#!/bin/sh
#
# e.hernandez - 2016
# choose the important colors, calculate the rest

# theme colors
FG=d0d0d0
BG=3a3a3a
WARN=ffd787

# midpoints between battery
# warning color and foreground
b0=d75f87
b1=d67686
b2=d48ca4
b3=d3a3b3
b4=d1b9c1
b5=d0d0d0

h2d() {
	echo "ibase=16; $(cat -)" | bc
}

rgb2D() {
	while read line ; do
		echo "ibase=16; $line" | bc
	done
}

h2RGB() {
	tr 'a-f' 'A-F' | fold -w 2 
}

midpoints() {
	n=$1 ; C1=$2 ; C2=$3

	diff=$((C1 - C2))
	diff=${diff#-}
	diff=$((diff / n + 1))

	i=1; while [[ $i -lt $((n + 1)) ]]; do
		echo $((C1 + i*diff))
		i=$((i + 1))
	done
}

#battery stuff
battery() {
	acpi --battery | cut -d, -f2 | tr -d '%'
}

batterycolor() {
	# i might take the log instead
	bl=$(expr $(battery) / 10)
	case $bl in
		0) cl=$bc0 ;;
		1) cl=$bc1 ;;
		2) cl=$bc2 ;;
		3) cl=$bc3 ;;
		4) cl=$bc4 ;;
		*) cl=$bc5 ;;
	esac
}
