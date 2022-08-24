#! /bin/sh

export DOCKER_BUILDKIT=1

echo "branch=$CI_COMMIT_REF_NAME"

# echo "$SDK_NUGETS_URL" > sdk_nugets_url.secret
# echo "$LOGATRON_CID_USR" > logatron_cid_usr.secret
echo "$LOGATRON_CID_PWD" > logatron_cid_pwd.secret
# echo "$LOGATRON_NUGETS_URL" > logatron_nugets_url.secret

cat logatron_cid_pwd.secret

echo  "BUILDING IMAGE  [$SUB_IMG_TAG] in [$CI_PROJECT_DIR]"
docker build \
  --file "$CI_PROJECT_DIR"/"$SUB_HOST"/Dockerfile \
  --tag "$SUB_IMG_TAG" \
  --tag "$SUB_IMG_TAG_LATEST" \
  --build-arg sdk_nugets_url="$SDK_NUGETS_URL" \
  --build-arg logatron_nugets_url="$LOGATRON_NUGETS_URL" \
  --build-arg logatron_cid_usr="$LOGATRON_CID_USR" \
  --build-arg logatron_cid_pwd="$LOGATRON_CID_PWD" \
  --secret id=cid_pwd,src=logatron_cid_pwd.secret \
  "$CI_PROJECT_DIR"
docker image history "$SUB_IMG_TAG"


echo "$LOGATRON_CID_PWD" | docker login -u "$LOGATRON_CID_USR"  "$LOGATRON_DOCKER_URL" --password-stdin

docker push "$SUB_IMG_TAG"
docker push "$SUB_IMG_TAG_LATEST"


