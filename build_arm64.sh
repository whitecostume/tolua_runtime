cd luajit-2.1/src

# Android/ARM64, arm64-v8a (AArch64), Android 5.0+
NDK=$ANDROID_NDK_HOME
NDKABI=21
NDKVER=$NDK/toolchains/llvm/prebuilt/linux-x86_64
NDKP=$NDKVER/bin/
NDKARCH="-DLJ_ABI_SOFTFP=0 -DLJ_ARCH_HASFPU=1"

# Add include paths and disable C++ features
NDKCC=$NDKP/aarch64-linux-android$NDKABI-clang
NDKCROSS=$NDKP/aarch64-linux-android-

make clean
make HOST_CC="clang -m64" CROSS=$NDKCROSS STATIC_CC=$NDKCC DYNAMIC_CC="$NDKCC -fPIC -O3" TARGET_LD=$NDKCC TARGET_AR="$NDKP/llvm-ar rcus" TARGET_STRIP="$NDKP/llvm-strip" TARGET_SYS=Linux TARGET_FLAGS="--sysroot $NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot $NDKARCH"
cp ./libluajit.a ../../android/jni/libluajit.a
make clean

cd ../../android
$NDK/ndk-build clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-21
$NDK/ndk-build APP_ABI="arm64-v8a" APP_PLATFORM=android-21 NDK_DEBUG=0 APP_OPTIM=release

mkdir -p ../Plugins/Android/libs/arm64-v8a
cp libs/arm64-v8a/libtolua.so ../Plugins/Android/libs/arm64-v8a
$NDK/ndk-build clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-21