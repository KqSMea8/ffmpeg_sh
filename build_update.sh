#!/bin/sh

set -xu
#git init
#git submodule update --init --recursive
ROOT_DIR=`pwd`

# true: 拉取最新代码并编译, false: 不更新代码仅编译
#bUpdate=false
bUpdate=true

# 目标平台
platform=android
#platform=ios

bUseOK=true

# 是否指定对应 commit id
bSpecifiCommitID=false

SRC_BRANCH=release/v3.7.8
ALIVC_FRAMEWORK_BRANCH=release/svideo_v3.7.8
ANDROID_BRANCH=release/v3.7.8
ANDROID_BRANCH=release/v3.7.8

echo "paramters num: $#"

if [ "true" == $bSpecifiCommitID ]; then
    if [ "true" == $bUseOK ]; then
        # 正常版本;
        SRC_COMMIT_ID=a97bff0c3c15d520ae686cba1ebcde88b9e5ca8b
        ALVCFRAME_COMMIT_ID=c306409
        ANDROID_COMMIT_ID=24387927fb4ef6d9e6d6994d23df2d435af47bae
        IOS_COMMIT_ID=
    else
        # 修改进度条位置引入问题版本; 
        SRC_COMMIT_ID=f8a2efb632d1e5521084b540ae218a18ff4179a3
        ALVCFRAME_COMMIT_ID=c306409
        ANDROID_COMMIT_ID=6169e7dd3375a4625b78d56e92e9211c08fa4993
        IOS_COMMIT_ID=
    fi
fi

if [ $# -gt 0 ]; then
    bUpdate=true
    echo "first parameter：$1";
fi
#echo "CQD, $1"

#echo "Shell 传递参数实例！";
echo "exectute name：$0";
#echo "第二个参数为：$2";
#echo "第三个参数为：$3";

if [ "true" == $bUpdate ]; then
    echo "update..."
	cd $ROOT_DIR/sources/native/src
    git reset --hard HEAD
	git pull origin
	git checkout $SRC_BRANCH
	git pull origin

    if [ "true" == $bSpecifiCommitID ]; then
       git reset --hard $SRC_COMMIT_ID
    fi 

    git log -n 3

	cd $ROOT_DIR/sources/native/modules/alivc_framework
    git reset --hard HEAD
	git pull origin
	git checkout $ALIVC_FRAMEWORK_BRANCH
	git pull origin

    if [ "true" == $bSpecifiCommitID ]; then
       git reset --hard $ALVCFRAME_COMMIT_ID
    fi
    git log -n 3


    if [ $platform == "android" ]; then
    	cd $ROOT_DIR/sources/android
        git reset --hard HEAD
    	git pull origin
    	git checkout $ANDROID_BRANCH
        git pull origin
        if [ "true" == $bSpecifiCommitID ]; then
           git reset --hard $ANDROID_COMMIT_ID
        fi
        git log -n 3
    else
	    cd $ROOT_DIR/sources/ios
        git reset --hard HEAD
	    git pull origin
    	git checkout $IOS_BRANCH
	    git pull origin
        if [ "true" == $bSpecifiCommitID ]; then
           git reset --hard $IOS_COMMIT_ID
        fi
	    git log -n 3
    fi
fi


rm -rf $ROOT_DIR/sources/android/.gradle-build
rm -rf $ROOT_DIR/sources/android/AliyunNative/.externalNativeBuild
rm -rf $ROOT_DIR/sources/android/STMobileJNI/.externalNativeBuild

cd $ROOT_DIR/sources/native/src

if [ $platform == "android" ]; then
    cd $ROOT_DIR/sources/android
    echo "`pwd`"
    ./build.sh install pro Debug Native
fi


if [ $platform == "ios" ]; then
    ./build-ios.sh
fi
