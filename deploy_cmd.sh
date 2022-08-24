#! /bin/sh
echo "branch=$CI_COMMIT_REF_NAME"

if [ "$CI_COMMIT_REF_NAME" != "master" ]; then
  CMD_IMG_TAG="$CMD_IMG_TAG-debug" 
fi
echo  DEPLOYING IMAGE  "$CMD_IMG_TAG" 

kubectl apply -f 
