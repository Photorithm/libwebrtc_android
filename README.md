This repository contains the Maven repo link for our custom Android WebRTC build, as well as setup and build scripts for modifying that repository.
All scripts only work on Linux (WSL is your friend on Windows, Mac users can suffer if they have issues)

Ensure `git` is installed and configured.
Ensure both OpenJDK and Maven are installed beforehand.

It is recommended to clone this repository inside an empty folder, as the setup and build scripts create folders in the directory above this repo on the local system.

run `setup.sh` from this directory to download the necessary tools from google, as well as our custom fork of Google's WebRTC, in the parent directory of this folder
make any changes desired to our custom webrtc repo, which will be located at `../google_webrtc_android/src`
run `build.sh` to build the webrtc code to an `.aar` file, generate the maven files, and write the results to this repository for distribution

Gradle may have a hard time updating to a newly pushed version; if so, clean the build cache (`flutter clean`), Android Studio's cache (the Invalidate caches and restart option), and the gradle cache (clear `.gradle/caches` wherever it happens to be found for your operating system)


