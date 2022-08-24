#! /bin/sh

export DOCKER_BUILDKIT=1

echo "branch=$CI_COMMIT_REF_NAME"

# echo "$SDK_NUGETS_URL" > sdk_nugets_url.secret
# echo "$LOGATRON_CID_USR" > logatron_cid_usr.secret
echo "$LOGATRON_CID_PWD" > logatron_cid_pwd.secret
# echo "$LOGATRON_NUGETS_URL" > logatron_nugets_url.secret

cat logatron_cid_pwd.secret

## BUILD HOSTS
echo  "BUILDING IMAGE  [$CMD_IMG_TAG] in [$CI_PROJECT_DIR]"
docker build \
  --file "$CI_PROJECT_DIR"/"$CMD_HOST"/Dockerfile \
  --tag "$CMD_IMG_TAG" \
  --tag "$CMD_IMG_TAG_LATEST" \
  --build-arg sdk_nugets_url="$SDK_NUGETS_URL" \
  --build-arg logatron_nugets_url="$LOGATRON_NUGETS_URL" \
  --build-arg logatron_cid_usr="$LOGATRON_CID_USR" \
  --build-arg logatron_cid_pwd="$LOGATRON_CID_PWD" \
  --secret id=cid_pwd,src=logatron_cid_pwd.secret \
  "$CI_PROJECT_DIR"
docker image history "$CMD_IMG_TAG"

## PUSH HOSTS
docker push "$CMD_IMG_TAG"
docker push "$CMD_IMG_TAG_LATEST"

