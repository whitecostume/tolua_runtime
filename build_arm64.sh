cd luajit-2.1/src

# Android/ARM64, arm64-v8a (AArch64), Android 5.0+
NDK=$ANDROID_NDK_HOME
NDKABI=21
NDKVER=$NDK/toolchains/llvm/prebuilt/linux-x86_64
NDKP=$NDKVER/bin/
NDKARCH="-DLJ_ABI_SOFTFP=0 -DLJ_ARCH_HASFPU=1"

# Add include paths and disable C++ features
NDKINC="-I$NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include -I$NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/aarch64-linux-android"
NDKDEFS="-D__ANDROID_API__=$NDKABI -D__ANDROID__ -DANDROID"

make clean
make HOST_CC="gcc -m64" CROSS=$NDKP TARGET_CC="$NDKP/aarch64-linux-android$NDKABI-clang" TARGET_LD="$NDKP/aarch64-linux-android$NDKABI-clang" TARGET_AR="$NDKP/llvm-ar rcus" TARGET_STRIP="$NDKP/llvm-strip" TARGET_SYS=Linux TARGET_FLAGS="--sysroot $NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot $NDKARCH" TARGET_CFLAGS="-fPIC $NDKINC $NDKDEFS"
cp ./libluajit.a ../../android/jni/libluajit.a
make clean

cd ../../android
$NDK/ndk-build clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-21
$NDK/ndk-build APP_ABI="arm64-v8a" APP_PLATFORM=android-21

mkdir -p ../Plugins/Android/libs/arm64-v8a
cp libs/arm64-v8a/libtolua.so ../Plugins/Android/libs/arm64-v8a
$NDK/ndk-build clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-21