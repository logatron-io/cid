#! /bin/sh

echo "branch=$CI_COMMIT_REF_NAME"
if [ "$CI_COMMIT_REF_NAME" != "master" ]; then
  QRY_IMG_TAG="$QRY_IMG_TAG-debug" 
fi

echo  BUILDING IMAGE  "$QRY_IMG_TAG" 
docker build -t "$QRY_IMG_TAG" -t  "$QRY_IMG_TAG_LATEST"  ./QRY
            
echo "$LOGATRON_CID_PWD" | docker login -u "$LOGATRON_CID_USR"  "$LOGATRON_DOCKER_URL" --password-stdin
docker push "$QRY_IMG_TAG"
docker push "$QRY_IMG_TAG_LATEST"
