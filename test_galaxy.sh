#!/usr/bin/env bash
set -e
echo -e "sleeping 90s, moving data to /export directory zzzzzz"
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
service supervisor start
sleep 15s
supervisorctl status
export BIOBLEND_GALAXY_URL="http://localhost:80"
sudo -E su $GALAXY_TRAVIS_USER -c "export PATH=$GALAXY_HOME/.local/bin/:$PATH &&
  cd $GALAXY_HOME &&
  bioblend-galaxy-tests -v $GALAXY_HOME/.local/lib/python2.7/site-packages/bioblend/_tests/TestGalaxy*.py"
