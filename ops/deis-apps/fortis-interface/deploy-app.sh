#!/usr/bin/env bash

export KUBECONFIG=/home/fortisadmin/.kube/config
export HELM_HOME=/home/fortisadmin/
export DEIS_PROFILE="/root/.deis/client.json"
eval "$(ssh-agent -s)"
source ./deis-apps/fortis-interface/.env

readonly CUSTOM_REACT_CREATE_APP_BP="https://github.com/heroku/heroku-buildpack-static.git"
export REACT_APP_SERVICE_HOST="${REACT_APP_SERVICE_HOST}"
export REACT_APP_FEATURE_SERVICE_HOST="${REACT_APP_FEATURE_SERVICE_HOST}"

cd project-fortis-interfaces || exit -2
ssh-add ../deis_certs

git fetch origin master
rm -rf webdeploy
git add -A
git commit -m "removing deployment assets"

deis config:set BUILDPACK_URL=${CUSTOM_REACT_CREATE_APP_BP}
npm install
npm run build
mv build webdeploy
echo '{"root": "webdeploy/"}' > static.json
git add -A
git commit -m "Adding deployment assets"
git push deis master
deis autoscale:set web --min=2 --max=5 --cpu-percent=75

cd .. || exit -2