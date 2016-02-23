#!/bin/dash
#
# e.hernandez - 2016
# choose the important colors, calculate the rest

# theme foreground and background
FG=a7adba
BG=2b303b
# warning color
WARN=ebcb8b

# midpoints between foreground and red
# to correspond to battery level
bc0=bf616a
bc1=b9747e
bc2=b38792
bc3=ad9aa6
bc4=a7adba
bc5=a7adba

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
