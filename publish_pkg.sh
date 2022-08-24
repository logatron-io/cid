#! /bin/bash


addInternals() {
    dotnet sln "$1" add "$SCHEMA_PKG"
    dotnet sln "$1" add "$CONTRACT_PKG"
    dotnet sln "$1" add "$DOMAIN_PKG"
}

addInfra() {
    dotnet sln "$1" add "$CLIENT_INFRA_PKG"
}



echo "branch=$CI_COMMIT_REF_NAME"
dotnet nuget add source "$SDK_NUGETS_URL" -n "M5x SDK Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text
dotnet nuget add source "$LOGATRON_NUGETS_URL" -n "Logatron Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text


## hosts solution 
dotnet new sln -n packages
addInternals packages.sln
addInfra packages.sln



dotnet restore --disable-parallel
if [ "$CI_COMMIT_REF_NAME" = "master" ]; then
  dotnet build -o ./PKG/ packages.sln
  for f in ./PKG/*.nupkg; do
    dotnet nuget push "$f" -k "$LOGATRON_NUGETS_API_KEY" -s "$LOGATRON_NUGETS_URL"
  done
else
  dotnet build -o ./PKG/ --version-suffix "debug" packages.sln
fi