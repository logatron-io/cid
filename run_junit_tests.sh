#! /bin/sh

echo  "branch=$CI_COMMIT_REF_NAME"
dotnet nuget add source "$SDK_NUGETS_URL" -n "M5x SDK Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text
dotnet nuget add source "$LOGATRON_NUGETS_URL" -n "Logatron Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text

if [ "$CI_COMMIT_REF_NAME" = "master" ]; then
  echo "UNIT TESTING RELEASE: [$1]"
  echo '*******************************************************************'
  ls -la "$1"/  
  echo '*******************************************************************'
  dotnet test --test-adapter-path:. --logger:"junit;LogFilePath=..\TEST-RES\artifacts\{assembly}-test-result.xml;MethodFormat=Class;FailureBodyFormat=Verbose" --configuration Release "$1"
  echo '*******************************************************************'
else
  echo "UNIT TESTING DEBUG: [$1]"
  echo '*******************************************************************'
  ls -la "$1"/
  echo '*******************************************************************'
  dotnet test --test-adapter-path:. --logger:"junit;LogFilePath=..\TEST-RES\artifacts\{assembly}-test-result.xml;MethodFormat=Class;FailureBodyFormat=Verbose" --configuration Debug "$1"
  echo '*******************************************************************'
  ls -la ./tests/unit
  echo '*******************************************************************'
fi

exit 0
