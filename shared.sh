#!/bin/sh
#
# e.hernandez - 2016
# depends on: acpi

# set borders
BW=3

# theme foreground and background
FG=d0d0d0
BG=3a3a3a
# warning color
WARN=ffd787

# midpoints between foreground and red
# to correspond to battery level
b0=d75f87
b1=d67686
b2=d48ca4
b3=d3a3b3
b4=d1b9c1
b5=d0d0d0

battery() {
	acpi --battery | cut -d, -f2 | tr -d '%'
}

batterycolor() {
	# i might take the log instead
	BL=$(( $(battery) / 10))
	case $BL in
		0) cl=$bc0 ;;
		1) cl=$bc1 ;;
		2) cl=$bc2 ;;
		3) cl=$bc3 ;;
		4) cl=$bc4 ;;
		*) cl=$bc5 ;;
	esac
}
