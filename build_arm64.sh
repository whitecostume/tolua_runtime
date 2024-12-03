cd luajit-2.1/src

# Android/ARM, armeabi-v7a (ARMv7 VFP), Android 4.0+ (ICS)
NDK=$ANDROID_NDK_HOME
NDKABI=21
NDKTRIPLE=aarch64-linux-android$NDKABI
NDKP=$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/
NDKCC=$NDKP/clang
NDKCXX=$NDKP/clang++
NDKF="--sysroot $NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot"
NDKARCH="-DLJ_ABI_SOFTFP=0 -DLJ_ARCH_HASFPU=1"

# Add include paths and disable C++ features
NDKINC="-I$NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include -I$NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/aarch64-linux-android"
NDKDEFS="-D_USING_LIBCXX=0 -D__ANDROID_API__=$NDKABI -U_Nonnull -U_Nullable -D_Nonnull= -D_Nullable= -U__attribute_pure__ -D__BIONIC_COMPLICATED_NULLNESS= -D__printflike(x,y)= -D__REMOVED_IN(x,y)= -D__INTRODUCED_IN(x)= -D__BIONIC_FORTIFY=0"

make clean
make HOST_CC="gcc -m64" CROSS_CC="$NDKCC -target $NDKTRIPLE" TARGET_SYS=Linux TARGET_FLAGS="$NDKF $NDKARCH" TARGET_CFLAGS="-fPIC -std=gnu99 $NDKINC $NDKDEFS"
cp ./libluajit.a ../../android/jni/libluajit.a
make clean

cd ../../android
$NDK/ndk-build clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-21
$NDK/ndk-build APP_ABI="arm64-v8a" APP_PLATFORM=android-21

mkdir -p ../Plugins/Android/libs/arm64-v8a
cp libs/arm64-v8a/libtolua.so ../Plugins/Android/libs/arm64-v8a
$NDK/ndk-build clean APP_ABI="armeabi-v7a,x86,arm64-v8a" APP_PLATFORM=android-21