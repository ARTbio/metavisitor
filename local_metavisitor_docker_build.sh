#!/usr/bin/env bash
set -e
apt-get update
apt-get install -y python-pip python-dev htop
apt-get -y remove docker docker-engine docker.io containerd runc
apt update
echo "Installing docker-ce"
sudo apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

echo "Upgrading pip"
python -m pip install -U pip
pip --version

echo "Installing ansible"
/usr/local/bin/pip install ansible==2.7.4
ansible --version
export GALAXY_TRAVIS_USER="galaxy"
export GALAXY_UID="1450"
export GALAXY_GID="1450"
export GALAXY_HOME="/home/galaxy"
export GALAXY_USER="admin@galaxy.org"
export GALAXY_USER_EMAIL="admin@galaxy.org"
export GALAXY_USER_PASSWD="admin"
export BIOBLEND_GALAXY_API_KEY="admin"
export BIOBLEND_TEST_JOB_TIMEOUT="120"
export BIOBLEND_GALAXY_URL="http://localhost"

git clone https://github.com/ARTbio/galaxykickstart.git
rm galaxykickstart/Dockerfile
cp Dockerfile galaxykickstart/
cp group_vars/metavisitor galaxykickstart/group_vars/
cp -a extra-files/metavisitor galaxykickstart/extra-files/
cp inventory_files/metavisitor galaxykickstart/inventory_files/
cd galaxykickstart/

docker build -t metavisitor . # the Dockerfile was copied from the root dir of metavisitor repo
sudo mkdir /export && sudo chown $GALAXY_UID:$GALAXY_GID /export
export CID1=`docker run -d -p 80:80 -p 21:21 -p 8800:8800 \
             --privileged=true \
             -e GALAXY_CONFIG_ALLOW_USER_DATASET_PURGE=True \
             -e GALAXY_CONFIG_ALLOW_LIBRARY_PATH_PASTE=True \
             -e GALAXY_CONFIG_ENABLE_USER_DELETION=True \
             -e GALAXY_CONFIG_ENABLE_BETA_WORKFLOW_MODULES=True \
             -v /tmp/:/tmp/ \
             -v /export:/export \
             metavisitor`


echo "Wait for exporting heavy tool data from container. You can track by typing\n
      `docker logs -f $CID1`\n
      `docker exec -it $CID1 supervisorctl status`\n
      `docker exec -it $CID1 service --status-all` "
