#! /bin/bash
echo "branch=$CI_COMMIT_REF_NAME"
for f in ./PKG/*.nupkg; do
   dotnet nuget push "$f" -k "$LOGATRON_NUGETS_API_KEY" -s "$LOGATRON_NUGETS_URL"
done




