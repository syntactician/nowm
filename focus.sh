#!/bin/sh

# e.hernandez
# a new focus wrapper based on Wildfyre, not z3bra

ARGS="$@"

usage() {
	cat << EOF
Usage: $(basename $0) <next|prev|wid>
	wid:  Focus the given window id.
	next: Focus the next window on the stack.
	prev: Focus the previous window on the stack.
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
	for n in $(lsw | grep -v $wid); do
		~/.wm/setborder.sh inactive $n
	done
	chwso -r $wid
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
