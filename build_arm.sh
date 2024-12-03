cd luajit-2.1/src

# Android/ARM, armeabi-v7a (ARMv7 VFP), Android 4.0+ (ICS)
NDK=$ANDROID_NDK_HOME
NDKABI=21
NDKTRIPLE=armv7a-linux-androideabi$NDKABI
NDKP=$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/
NDKCC=$NDKP/clang
NDKCXX=$NDKP/clang++
NDKF="--sysroot $NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot -D__ANDROID_API__=$NDKABI"
NDKARCH="-march=armv7-a -mfloat-abi=softfp -Wl,--fix-cortex-a8"

make clean
make HOST_CC="gcc -m32" CROSS_CC="$NDKCC -target $NDKTRIPLE" TARGET_SYS=Linux TARGET_FLAGS="$NDKF $NDKARCH" TARGET_CFLAGS="-fPIC -std=c11"
cp ./libluajit.a ../../android/jni/libluajit.a
make clean

cd ../../android
$NDK/ndk-build clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-21
$NDK/ndk-build APP_ABI="armeabi-v7a" APP_PLATFORM=android-21

mkdir -p ../Plugins/Android/libs/armeabi-v7a
cp libs/armeabi-v7a/libtolua.so ../Plugins/Android/libs/armeabi-v7a
$NDK/ndk-build clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-21