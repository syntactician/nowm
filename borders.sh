#!/bin/sh
#
# e.hernandez - 2016
# set/manage borders on all windows

ACT=$(pfw)
ROOT=$(lsw -r)

setborder() {
	wattr
