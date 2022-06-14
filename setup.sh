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
    fetch --nohooks -no-history webrtc_android
    cd ./src
    git checkout -B m93 25e3fd53a79bfdb2bd647ee3a199eb9c3a71d271 
    cd ..
    echo "syncing gclient"
    gclient sync --revision src@25e3fd53a79bfdb2bd647ee3a199eb9c3a71d271
    cd ./src
    ./build/install-build-deps.sh
    rm -r -f .git
    cd ../../
else 
    echo "project exists; skipping fetch"
fi

echo "removing old files"
[ -d "./tmp" ] && rm -r -f ./tmp

echo "cloning modified webrtc repository"
git clone -b main https://github.com/Photorithm/google_webrtc_android.git tmp
cd tmp 
git remote add upstream https://webrtc.googlesource.com/src
cd ..
echo "installing build dependencies"

echo "copying necessary files; this may take several minutes"
shopt -s dotglob nullglob
cp -r ./tmp/* .
echo "cleaning up temporary files; this may take several minutes"
rm -r -f ./tmp
echo "finished setup"
