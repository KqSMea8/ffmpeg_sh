#!/bin/bash
set -xu

ROOT_DIR=`pwd`


platform=android

# 1. 更新 ffmpeg 各版本库;
#cd sources/native/modules/alivc_framework/3rd/ffmpeg/ffsrc/ffmpeg
#git pull origin
#git checkout feature/merge_ffmpeg

cd $ROOT_DIR


# 2. 删除检测是否编译 ffmpeg 的根据 3rd/ffmpeg/ffbuild/open_all/iOS/* 下各库, 同时删除app 依赖的 framework

if [ $platform == "ios" ]; then
    rm -rf ./sources/native/modules/alivc_framework/3rd/ffmpeg/ffbuild/open_all/iOS/*
    rm -rf ./sources/ios/Lib/recordLib/QuCore-ThirdParty.framework/QuCore-ThirdParty
    rm -rf ./sources/ios/Lib/recordLib/QuCore-ThirdParty.framework/Info.plist
fi

if [ $platform == "android" ]; then
    rm -rf ./sources/native/modules/alivc_framework/3rd/ffmpeg/ffbuild/open_all/android/armeabi-v7a/lib/*
fi

cd $ROOT_DIR/sources/native/modules/alivc_framework/script/tool



# 3. 执行重新编译 QuCore-ThirdParty 的脚本;
if [ $platform == "ios" ]; then
    cd $ROOT_DIR/sources/native/modules/alivc_framework/script/tool
    ./build-iOS.sh

    cd $ROOT_DIR/sources/native/src
    ./build-ios.sh
    # 4. 将生成的framework 拷贝至目标文件夹中;
    cd $ROOT_DIR
    #cp -rf  ./sources/native/src/_generated/cmake_libs/ios/alivc_framework/lib/Debug/QuCore-ThirdParty.framework/*  ./sources/ios/Lib/recordLib/QuCore-ThirdParty.framework/
    cp -rf  ./sources/native/src/_generated/cmake_libs/ios/alivc_framework/lib/Release/QuCore-ThirdParty.framework/* ./sources/ios/Lib/recordLib/QuCore-ThirdParty.framework/
fi

if [ $platform == "android" ]; then
  cd $ROOT_DIR/sources/native/modules/alivc_framework/script/tool
  ./build-android.sh

  cd $ROOT_DIR/sources/native/src
  ./build-and.sh
fi
