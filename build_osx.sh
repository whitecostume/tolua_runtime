#!/usr/bin/env bash

cd macjit/
xcodebuild clean
xcodebuild -configuration=Release
cp -r build/Release/tolua.bundle ../Plugins/
