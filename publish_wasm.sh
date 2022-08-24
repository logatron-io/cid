#! /bin/sh
echo "branch=$CI_COMMIT_REF_NAME"
if [ "$CI_COMMIT_REF_NAME" != "master" ]; then
  WASM_IMG_TAG="$WASM_IMG_TAG-debug" 
fi
echo  BUILDING IMAGE  "$WASM_IMG_TAG" 
docker build -t "$WASM_IMG_TAG"  -t "$WASM_IMG_TAG_LATEST" ./WASM
echo "$LOGATRON_CID_PWD" | docker login -u "$LOGATRON_CID_USR"  "$LOGATRON_DOCKER_URL" --password-stdin
echo  PUSHING IMAGE  "$WASM_IMG_TAG" 
docker push "$WASM_IMG_TAG"
echo  PUSHING IMAGE  "$WASM_IMG_LATEST" 
docker push "$WASM_IMG_TAG_LATEST"
