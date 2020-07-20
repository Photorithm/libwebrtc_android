This repository contains the Maven repo link for our custom Android WebRTC build, as well as setup and build scripts for modifying that repository.
All scripts only work on Linux (WSL is your friend on Windows, Mac users can suffer if they have issues)

run `setup.sh` to download the necessary tools from google, as well as our custom fork of Google's WebRTC, in the parent directory of this folder
make any changes desired to our custom webrtc repo
run `build.sh` to build the webrtc code to an `.aar` file, generate the maven files, and write the results to this repository for distribution


