#!/usr/bin/env bash
set -e
set -o errexit

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
cd "$DIR"

cp -fa iglogger.smali ../OTGDiskExplorerPro302-apktool/smali/com/iglogger/

set +e
mkdir -p ../libaums-develop/app/src/main/java/com/iglogger
set -e

cp -fa com/iglogger/iglogger.jar ~/.m2/repository/com/iglogger/iglogger/0.0.1/iglogger-0.0.1.jar

rm -rf com/iglogger/*.jar

rsync -av com/iglogger/ "$DIR/../libaums-develop/app/src/main/java/com/iglogger"/
rm -f "../libaums-develop/app/src/main/java/com/iglogger/iglogger.*"

#mkdir -p "../libaums-develop/libaums/src/main/java/com/iglogger"
rsync -av com/iglogger/ "$DIR/../libaums-develop/libaums/src/main/java/com/iglogger/"
rm -f "../libaums-develop/libaums/src/main/java/com/iglogger/iglogger.*"

