cd luajit-2.1/src

# Android/ARM, armeabi-v7a (ARMv7 VFP), Android 4.0+ (ICS)
NDK=$ANDROID_NDK_HOME
NDKABI=21
NDKVER=$NDK/toolchains/llvm/prebuilt/linux-x86_64
NDKP=$NDKVER/bin/
NDKARCH="-march=armv7-a -mfloat-abi=softfp"

# Add include paths and disable C++ features
NDKCC=$NDKP/armv7a-linux-androideabi$NDKABI-clang
NDKCROSS=$NDKP/arm-linux-androideabi-

make clean
make HOST_CC="clang -m32" CROSS=$NDKCROSS STATIC_CC=$NDKCC DYNAMIC_CC="$NDKCC -fPIC -O3" TARGET_LD=$NDKCC TARGET_AR="$NDKP/llvm-ar rcus" TARGET_STRIP="$NDKP/llvm-strip" TARGET_SYS=Linux TARGET_FLAGS="--sysroot $NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot $NDKARCH"
cp ./libluajit.a ../../android/jni/libluajit.a
make clean

cd ../../android
$NDK/ndk-build clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-21
$NDK/ndk-build APP_ABI="armeabi-v7a" APP_PLATFORM=android-21 NDK_DEBUG=0 APP_OPTIM=release

mkdir -p ../Plugins/Android/libs/armeabi-v7a
cp libs/armeabi-v7a/libtolua.so ../Plugins/Android/libs/armeabi-v7a
$NDK/ndk-build clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-21