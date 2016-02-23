#!/bin/dash

# a new focus wrapper based on Wildfyre, not z3bra

ARGS="$@"

usage() {
	cat << EOF
Usage: $(basename $0) <next|prev|full|wid>
	wid:  Focus the given window id.
	next: Focus the next window on the stack.
	prev: Focus the previous window on the stack.
	full: Focus the fullscreen window.
EOF

	test -z $1 || exit $1
}

focusWid() {
	wattr $1 && wid=$1
	focusMethod
}

focusNext() {
	wid=$(lsw | grep -v $(pfw) | sed '1 p; d')
	focusMethod
}

focusPrev() {
	wid=$(lsw | grep -v $(pfw) | sed '$ p; d')
	focusMethod
}

focusMethod() {
	chwso -r $wid
	~/.wm/setborder.sh inactive $(pfw)
	wtf $wid
	~/.wm/setborder.sh active $(pfw)
}

main() {
	. ~/.wm/shared.sh

	case $1 in
		0x*)    focusWid  $1 ;;
		next)   focusNext    ;;
		prev)   focusPrev    ;;
		h|help) usage        ;;
		*)      usage        ;;
	esac

}

main $ARGS
