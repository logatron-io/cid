#! /bin/sh

echo "branch=$CI_COMMIT_REF_NAME"
if [ "$CI_COMMIT_REF_NAME" != "master" ]; then
  CLI_IMG_TAG="$CLI_IMG_TAG-debug"
  TUI_IMG_TAG="$TUI_IMG_TAG-debug"
fi

## BUILD CLIENTS
echo  BUILDING IMAGE  "$CLI_IMG_TAG" 
docker build -f "$CI_PROJECT_DIR"/CLI/Dockerfile -t "$CLI_IMG_TAG" -t  "$CLI_IMG_TAG_LATEST"  "$CI_PROJECT_DIR"/CLI

echo  BUILDING IMAGE  "$TUI_IMG_TAG" 
docker build -f "$CI_PROJECT_DIR"/TUI/Dockerfile -t "$TUI_IMG_TAG" -t  "$TUI_IMG_TAG_LATEST"  "$CI_PROJECT_DIR"/TUI

echo "$LOGATRON_CID_PWD" | docker login -u "$LOGATRON_CID_USR"  "$LOGATRON_DOCKER_URL" --password-stdin

## PUSH CLIENTS
docker push "$CLI_IMG_TAG"
docker push "$CLI_IMG_TAG_LATEST"

docker push "$TUI_IMG_TAG"
docker push "$TUI_IMG_TAG_LATEST"
