#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


SRCDIR=$DIR/luajit-2.1/
DESTDIR=$DIR/macjit

rm "$DESTDIR"/*.a
cd $SRCDIR

make clean
make && sudo make install
mv "$SRCDIR"/src/libluajit.a "$DESTDIR"/libluajit.a

cd ../macjit
xcodebuild clean
xcodebuild -configuration=Release
rm -rf ../Plugins/tolua.bundle
cp -r build/Release/tolua.bundle ../Plugins/
