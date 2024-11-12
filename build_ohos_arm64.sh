# OpenHarmony/ARM64, armeabi-v8a
dynamic_cc=${OHOS_SDK}/native/llvm/bin/aarch64-linux-ohos-clang
target_ld=${OHOS_SDK}/native/llvm/bin/aarch64-linux-ohos-clang
static_cc=${dynamic_cc}
export target_ar="${OHOS_SDK}/native/llvm/bin/llvm-ar rcus 2>/dev/null"
target_strip=${OHOS_SDK}/native/llvm/bin/llvm-strip


cd luajit-2.1/src

make clean
make -j32 HOST_CC="gcc" CFLAGS="-fPIC" DYNAMIC_CC=${dynamic_cc} TARGET_LD=${target_ld} STATIC_CC=${static_cc} TARGET_AR="${target_ar}" TARGET_STRIP=${target_strip} 
cp ./libluajit.a ../../openharmony/libluajit.a
make clean

cd ../../openharmony
${OHOS_SDK}/native/build-tools/cmake/bin/cmake -DCMAKE_TOOLCHAIN_FILE=${OHOS_SDK}/native/build/cmake/ohos.toolchain.cmake  -L 
make
mkdir -p ../Plugins/openharmony/libs/arm64-v8a
ls
cp openharmony/libtolua.so ../Plugins/openharmony/libs/arm64-v8a