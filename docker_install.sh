#!/usr/bin/env bash
set -e
apt-key adv --recv-keys --keyserver hkp://p80.pool.sks-keyservers.net:80 58118E89F3A912897C070ADBF76221572C52609D
add-apt-repository "deb https://apt.dockerproject.org/repo ubuntu-trusty main"
apt-get update -y
apt-get -y install docker-engine
echo "Docker system is installed\n"
export STANDARD=`docker run -d \
-p 80:80 -p 21:21 -p 8800:8800 --tmpfs /var/run/ \
--privileged=true \
-e GALAXY_CONFIG_ALLOW_USER_DATASET_PURGE=True \
-e GALAXY_CONFIG_ALLOW_LIBRARY_PATH_PASTE=True \
 -e GALAXY_CONFIG_ENABLE_USER_DELETION=True \
-e GALAXY_CONFIG_ENABLE_BETA_WORKFLOW_MODULES=True \
-v /tmp/:/tmp/ \
-v /export/:/export \
artbio/metavisitor-2`
