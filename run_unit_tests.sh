#! /bin/sh


addLibs() {
    dotnet sln "$1" add "src/internal/$API_NAME.Schema"
    dotnet sln "$1" add "src/internal/$API_NAME.Contract"
    dotnet sln "$1" add "src/internal/$API_NAME.Domain"
    dotnet sln "$1" add "src/internal/$API_NAME.Infra"
    dotnet sln "$1" add "src/internal/$API_NAME.Clients"
}

addHosts() {
    dotnet sln "$1" add "src/hosts/$API_NAME.Svc"
}


addUnitTests() {
    dotnet sln "$1" add "tests/unit/$API_NAME.Schema.UnitTests"
    dotnet sln "$1" add "tests/unit/$API_NAME.Contract.UnitTests"
    dotnet sln "$1" add "tests/unit/$API_NAME.Domain.UnitTests"
}


addAcceptanceTests() {
    dotnet sln "$1" add "tests/acceptance/$API_NAME.AcceptanceTests"
}

addIntegrationTests() {
    dotnet sln "$1" add "tests/integration/$API_NAME.Client.Infra.IntegrationTests"
    dotnet sln "$1" add "tests/integration/$API_NAME.Cmd.Infra.IntegrationTests"    
    dotnet sln "$1" add "tests/integration/$API_NAME.Etl.Infra.IntegrationTests"
    dotnet sln "$1" add "tests/integration/$API_NAME.Qry.Infra.IntegrationTests"
    dotnet sln "$1" add "tests/integration/$API_NAME.Sub.Infra.IntegrationTests"
}



echo  "branch=$CI_COMMIT_REF_NAME"
dotnet nuget add source "$SDK_NUGETS_URL" -n "M5x SDK Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text
dotnet nuget add source "$LOGATRON_NUGETS_URL" -n "Logatron Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text



# unit testing solution
dotnet new sln -n "$API_NAME".unit
addLibs "$API_NAME".unit.sln
addUnitTests "$API_NAME".unit.sln


if [ "$CI_COMMIT_REF_NAME" = "master" ]; then
  dotnet test --test-adapter-path:. --logger:trx --results-directory ../../UNIT-RES --verbosity quiet --configuration Release $1 
else
  dotnet test --test-adapter-path:. --logger:trx --results-directory ../../UNIT-RES --verbosity normal --configuration Debug $1 
fi
exit 0
