cd ..
[ -d "./tmp" ] && rm -r ./tmp
echo "cloning modified webrtc repository"
git clone https://github.com/Photorithm/google_webrtc_android.git tmp
cd tmp 
git remote add upstream https://webrtc.googlesource.com/src
cd ..
if [ ! -d "./depot_tools" ]
then
    echo "cloning depot tools repository"
    git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
else 
    echo "depot tools already exist; skipping clone"
fi
cd ./depot_tools
export PATH=$PATH:$(pwd)
cd ..
if [ ! -d "./google_webrtc_android" ]
then
    mkdir ./google_webrtc_android 
    cd ./google_webrtc_android
    echo "fetching webrtc_android from google; this may take multiple hours"
    fetch --nohooks webrtc_android
    echo "syncing gclient"
    gclient sync
    cd ./src
else 
    echo "project exists; skipping fetch"
    cd ./google_webrtc_android/src
fi
echo "installing build dependencies"
./build/install-build-deps.sh
rm -r .git
echo "copying necessary files; this may take several minutes"
shopt -s dotglob nullglob
cp -r ../../tmp/* .
echo "cleaning up temporary files; this may take several minutes"
rm -r ../../tmp
echo "finished setup"
