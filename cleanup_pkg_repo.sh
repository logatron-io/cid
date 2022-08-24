#! /bin/bash
echo "branch=$CI_COMMIT_REF_NAME"
dotnet nuget add source "$SDK_NUGETS_URL" -n "M5x SDK Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text
dotnet nuget add source "$LOGATRON_NUGETS_URL" -n "Logatron Nugets" -u "$LOGATRON_CID_USR" -p "$LOGATRON_CID_PWD" --store-password-in-clear-text

if [ "$CI_COMMIT_REF_NAME" != "master" ]; then
  API_VERSION="${API_VERSION}-debug"
fi
dotnet nuget delete "$CONTRACT_PKG" "$API_VERSION" -k "$LOGATRON_NUGETS_API_KEY" -s "$LOGATRON_NUGETS_URL" --non-interactive
dotnet nuget delete "$SCHEMA_PKG"   "$API_VERSION" -k "$LOGATRON_NUGETS_API_KEY" -s "$LOGATRON_NUGETS_URL" --non-interactive
dotnet nuget delete "$CLIENTS_PKG"  "$API_VERSION" -k "$LOGATRON_NUGETS_API_KEY" -s "$LOGATRON_NUGETS_URL" --non-interactive
exit 0




