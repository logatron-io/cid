#! /bin/sh
echo "branch=$CI_COMMIT_REF_NAME"
if [ "$CI_COMMIT_REF_NAME" != "master" ]; then
  CMD_IMG_TAG="$CMD_IMG_TAG-debug"
  ETL_IMG_TAG="$ETL_IMG_TAG-debug" 
  QRY_IMG_TAG="$QRY_IMG_TAG-debug"
  SUB_IMG_TAG="$SUB_IMG_TAG-debug"
  CLI_IMG_TAG="$CLI_IMG_TAG-debug"
  TUI_IMG_TAG="$TUI_IMG_TAG-debug"
fi

echo "$LOGATRON_CID_PWD" | docker login -u "$LOGATRON_CID_USR"  "$LOGATRON_DOCKER_URL" --password-stdin

## HOSTS
docker pull "$CMD_IMG_TAG" 
docker pull "$CMD_IMG_TAG_LATEST" 

docker pull "$ETL_IMG_TAG" 
docker pull "$ETL_IMG_TAG_LATEST" 

docker pull "$QRY_IMG_TAG" 
docker pull "$QRY_IMG_TAG_LATEST" 

docker pull "$SUB_IMG_TAG" 
docker pull "$SUB_IMG_TAG_LATEST" 


## CLIENTS
docker pull "$CLI_IMG_TAG" 
docker pull "$CLI_IMG_TAG_LATEST" 

docker pull "$TUI_IMG_TAG" 
docker pull "$TUI_IMG_TAG_LATEST" 


