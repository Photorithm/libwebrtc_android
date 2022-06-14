# Usage: 
#    setup.sh [sb-webrtc-branch-name]
MASTER="main"
BRANCH="${1:-$MASTER}"

cd ..
if [ -d "./tmp" ]
then 
    echo "removing old files"
    rm -r -f ./tmp
fi

echo "cloning modified webrtc repository"
git clone -b $BRANCH https://github.com/Photorithm/google_webrtc_android.git tmp
cd tmp 
git remote add upstream https://webrtc.googlesource.com/sr
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
    cd ./src
    echo "cleaning mismatched dependencies"
    git clean -ffd
    echo "checking out m93 branch"
    git checkout -B m93 25e3fd53a79bfdb2bd647ee3a199eb9c3a71d271 
    cd ..
    echo "syncing gclient with revision dependencies; this may take multiple hours"
    gclient sync -D --force --reset --with_branch_heads --revision src@25e3fd53a79bfdb2bd647ee3a199eb9c3a71d271
    cd ./src
    rm -r -f .git
    cd ../../
else 
    echo "project exists; skipping fetch"
fi

echo "copying necessary files; this may take several minutes"
shopt -s dotglob nullglob
cp -r ./tmp/* ./google_webrtc_android/src
echo "cleaning up temporary files; this may take several minutes"
rm -r -f ./tmp
echo "finished setup"
