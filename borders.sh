#!/bin/sh
#
# ez - 2016
# set/manage borders on all windows

ACT=$(pfw)
ROOT=$(lsw -r)

setborder() {
	wattr
