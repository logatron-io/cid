#! /bin/sh

export DOCKER_BUILDKIT=1

echo "branch=$CI_COMMIT_REF_NAME"

# echo "$SDK_NUGETS_URL" > sdk_nugets_url.secret
# echo "$LOGATRON_CID_USR" > logatron_cid_usr.secret
echo "$LOGATRON_CID_PWD" > logatron_cid_pwd.secret
# echo "$LOGATRON_NUGETS_URL" > logatron_nugets_url.secret

cat logatron_cid_pwd.secret

## BUILD HOSTS
echo  BUILDING IMAGE  ${CMD_IMG_TAG} in ${CI_PROJECT_DIR}
docker build \
  --file "$CI_PROJECT_DIR"/src/hosts/"$API_NAME".Cmd/Dockerfile \
  --tag "$CMD_IMG_TAG" \
  --tag "$CMD_IMG_TAG_LATEST" \
  --build-arg sdk_nugets_url="$SDK_NUGETS_URL" \
  --build-arg logatron_nugets_url="$LOGATRON_NUGETS_URL" \
  --build-arg logatron_cid_usr="$LOGATRON_CID_USR" \
  --build-arg logatron_cid_pwd="$LOGATRON_CID_PWD" \
  --secret id=cid_pwd,src=logatron_cid_pwd.secret \
  ${CI_PROJECT_DIR}
docker image history "$CMD_IMG_TAG"



echo  BUILDING IMAGE  ${QRY_IMG_TAG} in ${CI_PROJECT_DIR}
docker build \
  --file "$CI_PROJECT_DIR"/src/hosts/"$API_NAME".Qry/Dockerfile \
  --tag "$QRY_IMG_TAG" \
  --tag "$QRY_IMG_TAG_LATEST" \
  --build-arg sdk_nugets_url="$SDK_NUGETS_URL" \
  --build-arg logatron_nugets_url="$LOGATRON_NUGETS_URL" \
  --build-arg logatron_cid_usr="$LOGATRON_CID_USR" \
  --build-arg logatron_cid_pwd="$LOGATRON_CID_PWD" \
  --secret id=cid_pwd,src=logatron_cid_pwd.secret \
  ${CI_PROJECT_DIR}
docker image history "$QRY_IMG_TAG"


echo  BUILDING IMAGE  ${ETL_IMG_TAG} in ${CI_PROJECT_DIR}
docker build \
  --file "$CI_PROJECT_DIR"/src/hosts/"$API_NAME".Etl/Dockerfile \
  --tag "$ETL_IMG_TAG" \
  --tag "$ETL_IMG_TAG_LATEST" \
  --build-arg sdk_nugets_url="$SDK_NUGETS_URL" \
  --build-arg logatron_nugets_url="$LOGATRON_NUGETS_URL" \
  --build-arg logatron_cid_usr="$LOGATRON_CID_USR" \
  --build-arg logatron_cid_pwd="$LOGATRON_CID_PWD" \
  --secret id=cid_pwd,src=logatron_cid_pwd.secret \
  ${CI_PROJECT_DIR}
docker image history "$ETL_IMG_TAG"



echo  BUILDING IMAGE  ${SUB_IMG_TAG} in ${CI_PROJECT_DIR}
docker build \
  --file "$CI_PROJECT_DIR"/src/hosts/"$API_NAME".Sub/Dockerfile \
  --tag "$SUB_IMG_TAG" \
  --tag "$SUB_IMG_TAG_LATEST" \
  --build-arg sdk_nugets_url="$SDK_NUGETS_URL" \
  --build-arg logatron_nugets_url="$LOGATRON_NUGETS_URL" \
  --build-arg logatron_cid_usr="$LOGATRON_CID_USR" \
  --build-arg logatron_cid_pwd="$LOGATRON_CID_PWD" \
  --secret id=cid_pwd,src=logatron_cid_pwd.secret \
  ${CI_PROJECT_DIR}
docker image history "$SUB_IMG_TAG"

# ## BUILD CLIENTS

echo  BUILDING IMAGE  ${CLI_IMG_TAG} in ${CI_PROJECT_DIR}
docker build \
  --file "$CI_PROJECT_DIR"/src/clients/"$API_NAME".CLI/Dockerfile \
  --tag "$CLI_IMG_TAG" \
  --tag "$CLI_IMG_TAG_LATEST" \
  --build-arg sdk_nugets_url="$SDK_NUGETS_URL" \
  --build-arg logatron_nugets_url="$LOGATRON_NUGETS_URL" \
  --build-arg logatron_cid_usr="$LOGATRON_CID_USR" \
  --build-arg logatron_cid_pwd="$LOGATRON_CID_PWD" \
  --secret id=cid_pwd,src=logatron_cid_pwd.secret \
  ${CI_PROJECT_DIR}
docker image history "$CLI_IMG_TAG"


echo  BUILDING IMAGE  ${TUI_IMG_TAG} in ${CI_PROJECT_DIR}
docker build \
  --file "$CI_PROJECT_DIR"/src/clients/"$API_NAME".TUI/Dockerfile \
  --tag "$TUI_IMG_TAG" \
  --tag "$TUI_IMG_TAG_LATEST" \
  --build-arg sdk_nugets_url="$SDK_NUGETS_URL" \
  --build-arg logatron_nugets_url="$LOGATRON_NUGETS_URL" \
  --build-arg logatron_cid_usr="$LOGATRON_CID_USR" \
  --build-arg logatron_cid_pwd="$LOGATRON_CID_PWD" \
  --secret id=cid_pwd,src=logatron_cid_pwd.secret \
  ${CI_PROJECT_DIR}
docker image history "$TUI_IMG_TAG"


echo "$LOGATRON_CID_PWD" | docker login -u "$LOGATRON_CID_USR"  "$LOGATRON_DOCKER_URL" --password-stdin

## PUSH HOSTS
docker push "$CMD_IMG_TAG"
docker push "$CMD_IMG_TAG_LATEST"

docker push "$ETL_IMG_TAG"
docker push "$ETL_IMG_TAG_LATEST"

docker push "$QRY_IMG_TAG"
docker push "$QRY_IMG_TAG_LATEST"

docker push "$SUB_IMG_TAG"
docker push "$SUB_IMG_TAG_LATEST"

## PUSH CLIENTS
docker push "$CLI_IMG_TAG"
docker push "$CLI_IMG_TAG_LATEST"

docker push "$TUI_IMG_TAG"
docker push "$TUI_IMG_TAG_LATEST"
