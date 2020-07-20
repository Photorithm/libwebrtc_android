cd ..
rm -r -f google_webrtc_android
rm -r -f depot_tools
git clone https://github.com/Photorithm/google_webrtc_android.git
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
cd ./depot_tools
export PATH=$(pwd)
cd ./google_webrtc_android
gclient sync
cd src
./build/install-build-deps.sh
