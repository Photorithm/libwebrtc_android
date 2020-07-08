libwebrtc_android



Use the following to generate the maven files:

```
mvn install:install-file -DgroupId=com.aar.app -DartifactId=google-webrtc -Dversion=v2 -Dfile=/Users/photorithm/development/libwebrtc_android/com/aar/app/google-webrtc/v2/google-webrtc-v2.aar -Dpackaging=aar -DgeneratePom=true -DlocalRepository=/Users/photorithm/development/libwebrtc_android/com/aar/app/google-webrtc/v2 -DcreateChecksum=true
```