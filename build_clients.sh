#! /bin/bash

echo "branch=$CI_COMMIT_REF_NAME"
dotnet nuget add source "$SDK_NUGETS_URL" -n "M5x SDK Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text
dotnet nuget add source "$LOGATRON_NUGETS_URL" -n "Logatron Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text


cd "$CI_PROJECT_DIR"/src/clients/"$CLI_EXE" || exit
if [ "$CI_COMMIT_REF_NAME" = "master" ]; then
  dotnet publish -o "$CI_PROJECT_DIR"/CLI --runtime alpine-x64 --self-contained 
else
  dotnet publish -o "$CI_PROJECT_DIR"/CLI --runtime alpine-x64 --self-contained --version-suffix "debug" 
fi 

cd "$CI_PROJECT_DIR"/src/clients/"$TUI_EXE" || exit
if [ "$CI_COMMIT_REF_NAME" = "master" ]; then
  dotnet publish -o "$CI_PROJECT_DIR"/TUI --runtime alpine-x64 --self-contained 
else
  dotnet publish -o "$CI_PROJECT_DIR"/TUI --runtime alpine-x64 --self-contained --version-suffix "debug" 
fi 


## COPY DOCKERFILES for CLIENTS
cp "$CI_PROJECT_DIR"/src/clients/"$CLI_EXE"/Dockerfile "$CI_PROJECT_DIR"/CLI/Dockerfile
cp "$CI_PROJECT_DIR"/src/clients/"$TUI_EXE"/Dockerfile "$CI_PROJECT_DIR"/TUI/Dockerfile


du -sh "$CI_PROJECT_DIR"/CLI
du -sh "$CI_PROJECT_DIR"/TUI
