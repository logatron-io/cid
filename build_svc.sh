#! /bin/bash


addLibs() {
    dotnet sln "$1" add "src/lib/$API_NAME.Schema"
    dotnet sln "$1" add "src/lib/$API_NAME.Contract"
    dotnet sln "$1" add "src/lib/$API_NAME.Domain"
    dotnet sln "$1" add "src/lib/$API_NAME.Infra"
    dotnet sln "$1" add "src/lib/$API_NAME.Clients"
}

addHosts() {
    dotnet sln "$1" add "src/hosts/$API_NAME.Svc"
    # dotnet sln "$1" add "src/hosts/$API_NAME.Cmd"
    # dotnet sln "$1" add "src/hosts/$API_NAME.Qry"
    # dotnet sln "$1" add "src/hosts/$API_NAME.Etl"
    # dotnet sln "$1" add "src/hosts/$API_NAME.Sub"    
}


addUnitTests() {
    dotnet sln "$1" add "tests/unit/$API_NAME.Schema.UnitTests"
    dotnet sln "$1" add "tests/unit/$API_NAME.Data.UnitTests"
    dotnet sln "$1" add "tests/unit/$API_NAME.Contract.UnitTests"
    dotnet sln "$1" add "tests/unit/$API_NAME.Domain.UnitTests"
    dotnet sln "$1" add "tests/unit/$API_NAME.Infra.UnitTests"
}


addAcceptanceTests() {
    dotnet sln "$1" add "tests/acceptance/$API_NAME.AcceptanceTests"
}

addIntegrationTests() {
    dotnet sln "$1" add "tests/integration/$API_NAME.Clients.IntegrationTests"    
}


echo "branch=$CI_COMMIT_REF_NAME"
dotnet nuget add source "$SDK_NUGETS_URL" -n "M5x SDK Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text
dotnet nuget add source "$LOGATRON_NUGETS_URL" -n "Logatron Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text


## hosts solution 
dotnet new sln -n "$API_NAME".hosts
addLibs "$API_NAME".hosts.sln
addHosts "$API_NAME".hosts.sln


dotnet restore --disable-parallel
cd ./src/hosts/"$SVC_HOST" || exit
if [ "$CI_COMMIT_REF_NAME" = "master" ]; then
  dotnet publish -o "$CI_PROJECT_DIR"/SVC --runtime alpine-x64 --self-contained # "$API_NAME".hosts.sln
else
  dotnet publish -o "$CI_PROJECT_DIR"/SVC --runtime alpine-x64 --self-contained  --version-suffix "debug"  # "$API_NAME".hosts.sln
fi  
cp Dockerfile "$CI_PROJECT_DIR"/SVC/
