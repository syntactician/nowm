# `nowm`

`nowm` is a lightweight window management solution written in POSIX compliant
sh and [`wmutils`](https://wmutils.io).

### Known bugs

* `scratch.sh`, instead of the desired behavior, unmaps (or in some other way
  hides/destroys) the currently focused window.
* `wmp` does not move the mouse pointer.
	* neither does [`swarp`](https://tools.suckless.org/x/swarp).
