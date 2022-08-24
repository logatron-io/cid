#! /bin/sh
echo "branch=$CI_COMMIT_REF_NAME"

dotnet nuget add source "$SDK_NUGETS_URL" -n "M5x SDK Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text
dotnet nuget add source "$LOGATRON_NUGETS_URL" -n "Logatron Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text

cd cid
if [ "$CI_COMMIT_REF_NAME" != "master" ]; then
  API_VERSION="${API_VERSION}-debug"
fi

dotnet add cid.csproj package -v ${API_VERSION} -s ${LOGATRON_NUGETS_URL} -n ${API_NAME}.Schema
dotnet add cid.csproj package -v ${API_VERSION} -s ${LOGATRON_NUGETS_URL} -n ${API_NAME}.Contract
dotnet add cid.csproj package -v ${API_VERSION} -s ${LOGATRON_NUGETS_URL} -n ${API_NAME}.Client.Infra



dotnet restore --disable-parallel
# dotnet restore

exit 0




