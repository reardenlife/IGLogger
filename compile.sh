#!/usr/bin/env bash
set -e
set -o errexit

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
cd "$DIR"

cat com/iglogger/iglogger.java | sed "s/class iglogger/class Log/g" > com/iglogger/Log.java

javac -cp "/opt/android-sdk/platforms/android-26/android.jar" -source 1.8 -target 1.8 com/iglogger/iglogger.java
javac -cp "/opt/android-sdk/platforms/android-26/android.jar" -source 1.8 -target 1.8 com/iglogger/Log.java

dx --dex --output=iglogger.dex com/iglogger/iglogger.class
dx --dex --output=Log.dex com/iglogger/Log.class

apktool.sh b . -o iglogger.apk
apktool.sh d iglogger.apk -f -o iglogger-unpacked
rm -rf iglogger.apk
mv iglogger-unpacked/smali_iglogger/com/iglogger/iglogger.smali .
rm -rf iglogger-unpacked/

cd com/iglogger
jar cf iglogger.jar *.class
