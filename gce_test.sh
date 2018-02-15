#!/usr/bin/env bash
set -e
apt-get install -y python-pip python-dev python-setuptools git htop
echo "Upgrading pip to v 1.9"
pip install -U pip
pip --version
/usr/local/bin/pip install ansible==2.2
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
export BIOBLEND_GALAXY_URL="http://localhost:80/subdir/"

git clone https://github.com/ARTbio/GalaxyKickStart.git
rm -rf GalaxyKickStart/Dockerfile GalaxyKickStart/Dockerfile.test
mv Dockerfile Dockerfile.test GalaxyKickStart/
rm -rf GalaxyKickStart/group_vars/metavisitor GalaxyKickStart/group_vars/test 
mv group_vars/metavisitor group_vars/test GalaxyKickStart/group_vars/
rm -rf GalaxyKickStart/extra-files/metavisitor GalaxyKickStart/extra-files/test
mv extra-files/metavisitor extra-files/test GalaxyKickStart/extra-files/
rm -rf GalaxyKickStart/inventory_files/*
mv inventory_files/metavisitor inventory_files/test GalaxyKickStart/inventory_files/

cd GalaxyKickStart/
ansible-galaxy install -r requirements_roles.yml -p roles/ -f
echo "Editing group_vars/all"
sed -i -e 's/galaxy_manage_trackster: true/galaxy_manage_trackster: false/' group_vars/all
ansible-playbook -i inventory_files/test galaxy.yml
echo "Sleeping 15 sec before display status"
sleep 15
sudo supervisorctl status
echo "shut down supervisor service"
sudo service supervisor stop
sleep 5
docker build -t metavisitor -f Dockerfile.test .
sudo su $GALAXY_TRAVIS_USER -c 'pip install --ignore-installed --user https://github.com/galaxyproject/bioblend/archive/master.zip pytest'
sudo mkdir /export && sudo chown $GALAXY_UID:$GALAXY_GID /export
sudo mkdir ~/tmp && sudo chown $GALAXY_UID:$GALAXY_GID ~/tmp
export CID1=`docker run -d --privileged=true -p 80:80 -p 21:21 -e NAT_MASQUERADE=true -e NGINX_GALAXY_LOCATION=/subdir -v /export:/export -v ~/tmp/:/tmp/ metavisitor`

echo -e "sleeping 120s, moving data to /export directory zzzzzz"
sleep 120s
docker logs $CID1
echo -e "Testing CID1 $CID1"
curl http://localhost:80/subdir/api/version| grep version_major
sudo -E su $GALAXY_TRAVIS_USER -c "export PATH=$GALAXY_HOME/.local/bin/:$PATH &&
  cd $GALAXY_HOME &&
  bioblend-galaxy-tests -v $GALAXY_HOME/.local/lib/python2.7/site-packages/bioblend/_tests/TestGalaxy*.py"
curl --fail ${BIOBLEND_GALAXY_URL}api/version
docker exec -it $CID1 supervisorctl status | grep proftpd | grep RUNNING
date > $HOME/date.txt && curl --fail -T $HOME/date.txt ftp://localhost:21 --user $GALAXY_USER:$GALAXY_USER_PASSWD
docker stop $CID1 && docker rm $CID1
sudo service supervisor start
sleep 15s
sudo supervisorctl status
export BIOBLEND_GALAXY_URL="http://localhost:80"
sudo -E su $GALAXY_TRAVIS_USER -c "export PATH=$GALAXY_HOME/.local/bin/:$PATH &&
  cd $GALAXY_HOME &&
  bioblend-galaxy-tests -v $GALAXY_HOME/.local/lib/python2.7/site-packages/bioblend/_tests/TestGalaxy*.py"

