#!/bin/dash
#
# e.hernandez - 2016
# first attempt at implementing full-screen windows

PANEL=15
GAP=25

WID=$(pfw)
BW=$(wattr b $WID)

ROOT=$(lsw -r)
SW=$(wattr w $ROOT)
SH=$(wattr h $ROOT)

SH=$((SH - PANEL))

WW=$(($SW - 2*$GAP - 2*$BW))
WH=$(($SH - 2*$GAP - 2*$BW - $PANEL))

#if [ "$wd" != "$rd" ]; then
if [ -f ~/.wm/.fw ] ; then
	# 10 points if you can remove this
	# UUOC w/out breaking the functionality
	wtp `cat ~/.wm/.fw`
	rm -f ~/.wm/.fw
else
	wattr xywhi $WID  >~/.wm/.fw
	# wtp -$bw -$bw $rd $WID
	wtp $GAP $((GAP + PANEL)) $WW $WH $WID
fi
