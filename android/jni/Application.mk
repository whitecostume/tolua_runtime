# The ARMv7 is significanly faster due to the use of the hardware FPU
 APP_ABI := armeabi-v7a arm64-v8a

 #安卓平台的名称,比如android-16
 # APP_PLATFORM := android-19

 #指定使用C++进行编程时所以来的标准库,默认libstdc++
 APP_STL := c++_static

 #选择GCC编译器版本,64位ABI默认使用版本4.9,32位ABI默认使用版本4.8,要选择Clang的版本,变量定义为clang3.4、clang3.5或clang
 NDK_TOOLCHAIN_VERSION := clang

 APP_SUPPORT_FLEXIBLE_PAGE_SIZES := true