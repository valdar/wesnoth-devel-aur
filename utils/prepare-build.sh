#!/bin/bash
if [[ $# -ne 1 ]]; then
    echo "Illegal number of parameters, a single parameter with the update version is needed (i.e. 1.19.7)" >&2
    exit 2
fi

# download new version
version="$1"
wget https://downloads.sourceforge.net/sourceforge/wesnoth/wesnoth-$version.tar.bz2

# update PKGBUILD
sha=`sha256sum  wesnoth-$version.tar.bz2 | cut -d ' ' -f 1`
sed -i "s/^pkgver=.*/pkgver=$version/g" PKGBUILD
sed -i "s/^sha256sums=(.*/sha256sums=('$sha'/g" PKGBUILD
