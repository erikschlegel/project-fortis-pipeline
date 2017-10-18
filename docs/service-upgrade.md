![image](https://user-images.githubusercontent.com/7635865/31617556-20d8f110-b255-11e7-8b2b-67bf741228fd.png)

# Fortis Service Upgrade
The Fortis service server runs on Deis and Kubernetes. Deis is an open source heroku-inspired PaaS that helps manage and deploy applications on your own hardware. 

## Prerequisite
- A deployed Fortis pipeline
- Deployment public / private key locally installed
- Ensure the local ssh-agent is running `eval $(ssh-agent -s)`
- Ensure the deployment SSH private key is added to the agent `ssh-add ~/.ssh/K8`
- SSH'd into the Fortis jumpbox

## Deployment steps
- All below steps should take place on the Fortis jumpbox. 

### Environment setup

#### Elevate permissions

```bash
sudo su
```

#### Deploy latest services codebase to Fortis cluster

```
cd /var/lib/waagent/custom-script/download/0/fortisdeploy/ops/
./deis-apps/fortis-services/deploy-app.sh
```