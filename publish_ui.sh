#! /bin/sh

echo "branch=$CI_COMMIT_REF_NAME"
if [ "$CI_COMMIT_REF_NAME" != "master" ]; then
  UI_IMG_TAG="$UI_IMG_TAG-debug" 
fi
echo  BUILDING IMAGE  "$UI_IMG_TAG" 
docker build -t "$UI_IMG_TAG"  -t "$UI_IMG_TAG_LATEST" ./UI
echo "$LOGATRON_CID_PWD" | docker login -u "$LOGATRON_CID_USR"  "$LOGATRON_DOCKER_URL" --password-stdin
docker push "$UI_IMG_TAG"
docker push "$UI_IMG_TAG_LATEST"
