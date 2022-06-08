# usage: ./setup.sh (OPT)SRC_BRANCH_NAME
# example (origin): ./setup.sh fix/something
MASTER="main"
BRANCH="${1:-$MASTER}"
GOOGLE_WEBRTC_DIR="./google_webrtc_android"


cd ..
if [ ! -d $GOOGLE_WEBRTC_DIR ]
then
    mkdir $GOOGLE_WEBRTC_DIR
fi
cd $GOOGLE_WEBRTC_DIR

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
if [ ! -d "./src" ]
then
    mkdir ./src 
    cd ./src
    # export GIT_DISCOVERY_ACROSS_FILESYSTEM=1 #helps with issues running in wsl
    echo "cloning modified webrtc repository"
    git clone -b $BRANCH https://github.com/Photorithm/google_webrtc_android.git .
    git remote add upstream https://github.com/webrtc-sdk/webrtc
    # git config checkout.defaultRemote origin
else 
    echo "cloned source already exists; switching to branch ${BRANCH}"
    cd ./src
    git fetch upstream
    git checkout $BRANCH
fi
echo "finished setup"
