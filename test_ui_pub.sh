#! /bin/sh
echo "branch=$CI_COMMIT_REF_NAME"
if [ "$CI_COMMIT_REF_NAME" != "master" ]; then
  UI_IMG_TAG="${UI_IMG_TAG}-debug" 
fi

echo "$LOGATRON_CID_PWD" | docker login -u "$LOGATRON_CID_USR"  "$LOGATRON_DOCKER_URL" --password-stdin

docker pull "${UI_IMG_TAG}" 
docker pull "${UI_IMG_TAG_LATEST}" 





