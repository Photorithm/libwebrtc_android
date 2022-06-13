cd ../google_webrtc_android/depot_tools
export PATH=$PATH:$(pwd)
cd ../src
echo "building aar file... please wait"
vpython ./tools_webrtc/android/build_aar.py --verbose
cd ../..
echo "removing old build"
rm ./google_webrtc_android/google-webrtc-v3.aar
rm -r ./libwebrtc_android/com/aar/app/google-webrtc/*
cp ./google_webrtc_android/libwebrtc.aar ./google_webrtc_android/google-webrtc-v3.aar
mvn install:install-file -DgroupId=com.aar.app -DartifactId=google-webrtc -Dversion=v3 -Dfile=./google_webrtc_android/src/google-webrtc-v3.aar -Dpackaging=aar -DgeneratePom=true -Dlocalrepository=./libwebrtc_android/com/aar/app/google-webrtc/v3 -DcreateChecksum=true
echo "copying maven files to repository"
cp -R ~/.m3/repository/com/aar/app/google-webrtc/* ./libwebrtc_android/com/aar/app/google-webrtc/
cd ./libwebrtc_android
echo "uploading files to git"
git checkout repo 
git add .
git commit -m "update aar"
git push
echo "finished build"

