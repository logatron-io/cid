#! /bin/bash
echo "branch=$CI_COMMIT_REF_NAME"
dotnet nuget add source "$SDK_NUGETS_URL" -n "M5x SDK Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text
dotnet nuget add source "$LOGATRON_NUGETS_URL" -n "Logatron Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text
dotnet restore --disable-parallel
cd ./src/"$UI_HOST" || exit
if [ "$CI_COMMIT_REF_NAME" = "master" ]; then
  dotnet publish -o ../../UI --runtime centos.7-x64 --self-contained 
else
  dotnet publish -o ../../UI --runtime centos.7-x64 --self-contained --version-suffix "debug"
fi 
cp Dockerfile ../../UI/
