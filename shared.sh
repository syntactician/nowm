
#!/bin/dash
#
# syntactician - 2016
# depends on: acpi

# set borders
BW=3

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
