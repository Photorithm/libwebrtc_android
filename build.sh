cd ../depot_tools
export PATH=$PATH:$(pwd)
cd ../google_webrtc_android
echo "building aar file... please wait"
script_output=$(/tools_webrtc/android/build_aar.py 2>&1)
echo $script_output
cd ../
echo "removing old build"
rm ./google_webrtc_android/google-webrtc-v2.aar
rm -r ./libwebrtc_android/com/aar/app/google-webrtc/*
cp ./google_webrtc_android/libwebrtc.aar ./google_webrtc_android/google-webrtc-v2.aar
mvn install:install-file -DgroupId=com.aar.app -DartifactId=google-webrtc -Dversion=v2 -Dfile=./google_webrtc_android/google-webrtc-v2.aar -Dpackaging=aar -DgeneratePom=true -Dlocalrepository=./libwebrtc_android/com/aar/app/google-webrtc/v2 -DcreateChecksum=true
echo "copying maven files to repository"
cp -R ~/.m2/repository/com/aar/app/google-webrtc/* ./libwebrtc_android/com/aar/app/google-webrtc/
cd ./libwebrtc_android
echo "uploading files to git"
git checkout repo 
git add .
git commit -m "update aar"
git push

