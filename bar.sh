#!/bin/sh
#
# e.hernandez - 2016
# depends on: lemonbar acpi shared.sh
# usage: bar.sh | lemonbar -p

battNum(){
	acpi --battery | cut -d, -f2 | tr -d '%'
}

battSym(){
	stat="$(acpi --battery | awk '{print $3}')"
	sym=''

	case $stat in
		'Charging,')    sym='+' ;;
		'Discharging,') sym='-' ;;
	esac

	echo "$sym"
}

clock(){
	date +"%k%M"
}

cal() {
	date +"%a, %d %b"
}

main(){
	. ~/.wm/shared.sh

	#background and foreground color from theme
	barfg="%{F#$FG}"
	barbg="%{B#$BG}"

	while true; do
		batterycolor
		$battfg="%{F#$cl}"
		echo "$barbg\
			  %{l}$battfg $(battNum)$(battSym)\
			  %{c}$barfg $(cal)\
			  %{r}$(clock)  "
		sleep 1
	done
}

main
