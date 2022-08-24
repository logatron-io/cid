#! /bin/sh
echo "branch=$CI_COMMIT_REF_NAME"
if [ "$CI_COMMIT_REF_NAME" != "master" ]; then
  ETL_IMG_TAG="${SUB_IMG_TAG}-debug" 
fi

echo "$LOGATRON_CID_PWD" | docker login -u "$LOGATRON_CID_USR"  "$LOGATRON_DOCKER_URL" --password-stdin

docker pull "${ETL_IMG_TAG}" 
docker pull "${ETL_IMG_TAG_LATEST}" 





