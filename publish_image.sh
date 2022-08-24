#! /bin/sh

# $1 = PROJECT
# $2 = IMAGE_TAG
# $3 = IMAGE_TAG_LATEST

echo "branch=$CI_COMMIT_REF_NAME"

## BUILD
echo  BUILDING IMAGE  $2, $3 
docker build -f "$CI_PROJECT_DIR"/$1/Dockerfile -t $2 -t  $3  "$CI_PROJECT_DIR"/$1

echo "$LOGATRON_CID_PWD" | docker login -u "$LOGATRON_CID_USR"  "$LOGATRON_DOCKER_URL" --password-stdin

## PUSH HOSTS
docker push $2
docker push $3