#! /bin/bash

echo "branch=$CI_COMMIT_REF_NAME"
dotnet nuget add source "$SDK_NUGETS_URL" -n "M5x SDK Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text
dotnet nuget add source "$LOGATRON_NUGETS_URL" -n "Logatron Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text




cd "$CI_PROJECT_DIR"/src/clients/"$CLI_EXE" || exit
# dotnet restore --disable-parallel 
if [ "$CI_COMMIT_REF_NAME" = "master" ]; then
  dotnet publish -o "$CI_PROJECT_DIR"/CLI --runtime alpine-x64 --self-contained 
else
  dotnet publish -o "$CI_PROJECT_DIR"/CLI --runtime alpine-x64 --self-contained --version-suffix "debug" 
fi 
cp Dockerfile "$CI_PROJECT_DIR"/CLI/
