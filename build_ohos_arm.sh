# OpenHarmony/ARM, armeabi-v7a
dynamic_cc=${OHOS_SDK}/native/llvm/bin/armv7-unknown-linux-ohos-clang
target_ld=${OHOS_SDK}/native/llvm/bin/armv7-unknown-linux-ohos-clang
static_cc=${dynamic_cc}
export target_ar="${OHOS_SDK}/native/llvm/bin/llvm-ar rcus 2>/dev/null"
target_strip=${OHOS_SDK}/native/llvm/bin/llvm-strip
cmake_tool=${OHOS_SDK}/native/build-tools/cmake/bin/cmake
toolchain_tool=${OHOS_SDK}/native/build/cmake/ohos.toolchain.cmake


cd luajit-2.1/src

make clean
make -j32 HOST_CC="gcc -m32" CFLAGS="-fPIC" XCFLAGS=-DLUAJIT_DISABLE_JIT DYNAMIC_CC=${dynamic_cc} TARGET_LD=${target_ld} STATIC_CC=${static_cc} TARGET_AR="${target_ar}" TARGET_STRIP=${target_strip} 
cp ./libluajit.a ../../openharmony/libluajit.a
make clean

cd ../../openharmony
mkdir -p build  # 创建一个构建目录
cd build
${cmake_tool} -DCMAKE_TOOLCHAIN_FILE=${toolchain_tool} -DOHOS_ARCH=armeabi-v7a ..  -L 
make -j32
ls
cd ..
mkdir -p ../Plugins/openharmony/libs/armeabi-v7a
cp build/libtolua.so ../Plugins/openharmony/libs/armeabi-v7a