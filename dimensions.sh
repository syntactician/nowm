#!/bin/sh
# e.hernandez
# stores the size of gaps, borders, etc

# window border size
BW=3
# height of the top panel
PANEL=15
# gap between windows
GAP=25

# screen height and width
ROOT=$(lsw -r)
SH=$(wattr h $ROOT)
SW=$(wattr w $ROOT)

# usable height and width
FH=$((SH - 2*BW - 2*GAP - PANEL))
FW=$((SW - 2*BW - 2*GAP))

# height and width of half-screen windows
HH=$((SH/2 - GAP - GAP/2 - 2*BW))
HW=$((SW/2 - GAP - GAP/2 - 2*BW))

# X and Y of full windows
FX=$GAP
FY=$((GAP + PANEL))

# X and Y of right/bottom half windows
HX=$((SW/2 + GAP/2))
HY=$((SH/2 + GAP/2 + PANEL))
