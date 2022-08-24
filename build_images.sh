#! /bin/bash

echo "branch=$CI_COMMIT_REF_NAME"
dotnet nuget add source "$SDK_NUGETS_URL" -n "M5x SDK Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text
dotnet nuget add source "$LOGATRON_NUGETS_URL" -n "Logatron Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text


## BUIL ALL
cd "$CI_PROJECT_DIR"/src/hosts/"$CMD_HOST" || exit
if [ "$CI_COMMIT_REF_NAME" = "master" ]; then
  dotnet publish -o "$CI_PROJECT_DIR"/CMD --runtime alpine-x64 --self-contained 
else
  dotnet publish -o "$CI_PROJECT_DIR"/CMD --runtime alpine-x64 --self-contained --version-suffix "debug" 
fi 

cd "$CI_PROJECT_DIR"/src/hosts/"$ETL_HOST" || exit
if [ "$CI_COMMIT_REF_NAME" = "master" ]; then
  dotnet publish -o "$CI_PROJECT_DIR"/ETL --runtime alpine-x64 --self-contained 
else
  dotnet publish -o "$CI_PROJECT_DIR"/ETL --runtime alpine-x64 --self-contained --version-suffix "debug" 
fi 

cd "$CI_PROJECT_DIR"/src/hosts/"$QRY_HOST" || exit
if [ "$CI_COMMIT_REF_NAME" = "master" ]; then
  dotnet publish -o "$CI_PROJECT_DIR"/QRY --runtime alpine-x64 --self-contained 
else
  dotnet publish -o "$CI_PROJECT_DIR"/QRY --runtime alpine-x64 --self-contained --version-suffix "debug" 
fi 

cd "$CI_PROJECT_DIR"/src/hosts/"$SUB_HOST" || exit
if [ "$CI_COMMIT_REF_NAME" = "master" ]; then
  dotnet publish -o "$CI_PROJECT_DIR"/SUB --runtime alpine-x64 --self-contained 
else
  dotnet publish -o "$CI_PROJECT_DIR"/SUB --runtime alpine-x64 --self-contained --version-suffix "debug" 
fi 

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



## COPY DOCKERFILES for HOSTS
cp "$CI_PROJECT_DIR"/src/hosts/"$CMD_HOST"/Dockerfile "$CI_PROJECT_DIR"/CMD/Dockerfile
cp "$CI_PROJECT_DIR"/src/hosts/"$QRY_HOST"/Dockerfile "$CI_PROJECT_DIR"/QRY/Dockerfile
cp "$CI_PROJECT_DIR"/src/hosts/"$ETL_HOST"/Dockerfile "$CI_PROJECT_DIR"/ETL/Dockerfile
cp "$CI_PROJECT_DIR"/src/hosts/"$SUB_HOST"/Dockerfile "$CI_PROJECT_DIR"/SUB/Dockerfile

## COPY DOCKERFILES for CLIENTS
cp "$CI_PROJECT_DIR"/src/clients/"$CLI_EXE"/Dockerfile "$CI_PROJECT_DIR"/CLI/Dockerfile
cp "$CI_PROJECT_DIR"/src/clients/"$TUI_EXE"/Dockerfile "$CI_PROJECT_DIR"/TUI/Dockerfile


du -sh "$CI_PROJECT_DIR"/CMD
du -sh "$CI_PROJECT_DIR"/ETL
du -sh "$CI_PROJECT_DIR"/QRY
du -sh "$CI_PROJECT_DIR"/SUB
du -sh "$CI_PROJECT_DIR"/CLI
du -sh "$CI_PROJECT_DIR"/TUI
