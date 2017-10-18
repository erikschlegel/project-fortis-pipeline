#!/usr/bin/env bash

export KUBECONFIG=/home/fortisadmin/.kube/config
export HELM_HOME=/home/fortisadmin/
export DEIS_PROFILE="/root/.deis/client.json"
eval "$(ssh-agent -s)"
ssh-add ./deis_certs
deis keys:add deis_certs.pub

cd project-fortis-services || exit -2
git fetch origin master
git add -A
git commit -m "Adding deployment assets"

git push deis master
deis autoscale:set web --min=2 --max=4 --cpu-percent=75

cd .. || exit -2