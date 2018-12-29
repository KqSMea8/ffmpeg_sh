
if [ bUpdate == "true" ]; then
ios_commit=release/v3.7.0
src_commit=release/v3.7.0
alivc_commit=release/svideo_v3.7.0


git submodule init
git submodule update --recursive --progress


cd ./sources/ios
git checkout $ios_commit
cd -

cd ./sources/native/src
git checkout $src_commit
cd -

cd ./sources/native/modules/alivc_framework
git checkout $alivc_commit
cd -

cd ./sources/native/modules/alivc_framework/3rd/ffmpeg/ffsrc/ffmpeg
git submodule init
git submodule update --progress
git checkout feature/alivc-ffmpeg-v1.0
cd -
fi



cd ./sources/native/src
sh ./build-ios-lipo.sh
cd ../../ios
cp ../native/src/build/QuCore-RCE/ios/QuSynth.a ./Lib/recordLib/QuSynth.a
sh ./build_custom.sh
