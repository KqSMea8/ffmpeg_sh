ROOT_DIR=`pwd`
mkdir -p outPacket


cp -r ./sources/android/outDemo/AliyunVideoSdk/AliyunSdk-RCE.aar ./outPacket/
cp -r ./sources/android/outDemo/Demo/src/main/libs/armeabi-v7a   ./outPacket/
cp -r ./sources/android/outDemo/Demo/src/main/libs/arm64-v8a     ./outPacket/
cp -r ./sources/android/outDemo/Demo/libs/AlivcCore.jar          ./outPacket/
