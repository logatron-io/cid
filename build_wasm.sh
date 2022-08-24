#! /bin/bash
echo "branch=$CI_COMMIT_REF_NAME"
cd ./src/"$WASM_HOST" || exit
dotnet nuget add source "$SDK_NUGETS_URL" -n "M5x SDK Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text
dotnet nuget add source "$LOGATRON_NUGETS_URL" -n "Logatron Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text

dotnet sln remove src/"$CLI_EXE"

dotnet sln remove src/"$QRY_HOST"
dotnet sln remove src/"$ETL_HOST"
dotnet sln remove src/"$SUB_HOST"
dotnet sln remove src/"$CMD_HOST"

dotnet sln remove tests/"$BDD_TEST_PKG"
dotnet sln remove tests/"$DOMAIN_TEST_PKG"
dotnet sln remove tests/"$CONTRACT_TEST_PKG"
dotnet sln remove tests/"$SCHEMA_TEST_PKG"
dotnet sln remove tests/"$DATA_TEST_PKG"


dotnet restore --disable-parallel
if [ "$CI_COMMIT_REF_NAME" = "master" ]; then
  dotnet publish -o ../../WASM --runtime centos.7-x64 --self-contained 
else
  dotnet publish -o ../../WASM --runtime centos.7-x64 --self-contained --version-suffix "debug"
fi 
cp Dockerfile ../../WASM/
cp nginx.conf ../../WASM/
