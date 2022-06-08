# usage: ./setup.sh (OPT)SRC_BRANCH_NAME
# example (origin): ./setup.sh fix/something
# example (upstream): ./setup.sh "-b main upstream/main"
MASTER="main"
BRANCH="${1:-$MASTER}"

cd ..
if [ ! -d "./depot_tools" ]
then
    echo "cloning depot tools repository"
    git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
else 
    echo "depot tools already exists; skipping clone"
fi
cd ./depot_tools
export PATH=$PATH:$(pwd)
cd ..
if [ ! -d "./google_webrtc_android" ]
then
    # export GIT_DISCOVERY_ACROSS_FILESYSTEM=1 #helps with issues running in wsl
    echo "cloning modified webrtc repository with branch ${BRANCH}"
    git clone https://github.com/Photorithm/google_webrtc_android.git 
    cd ./google_webrtc_android
    git remote add upstream https://github.com/webrtc-sdk/webrtc

else 
    echo "cloned source already exists; switching to branch ${BRANCH}"
    cd ./google_webrtc_android
fi
git fetch upstream
git checkout $BRANCH
echo "finished setup"
