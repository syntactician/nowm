#!/bin/dash
#
# ez - 2016
# depends on: lemonbar acpi shared.sh
# usage: bar.sh | lemonbar -p
 
. ~/.wm/shared.sh

#background and foreground color from theme
barfg="%{F#$FG}"
barbg="%{B#$BG}"

clock(){
	date +"%k%M"
}

cal() {
	date +"%a, %d %b"
}

while true; do
	batterycolor
	echo "$barbg%{F#$cl} $(battery)% $barfg %{c}$(cal)%{r}$(clock)  "
	sleep 1
done
