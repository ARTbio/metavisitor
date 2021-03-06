#!/usr/bin/env bash
set -e
echo "$TRAVIS_JOB has been received"

if [[ $TRAVIS_JOB = "docker" ]]; then
    echo "Docker connection Checks"
    curl --fail ${BIOBLEND_GALAXY_URL}/api/version
    date > $HOME/date.txt && curl --fail -T $HOME/date.txt ftp://localhost:21 --user $GALAXY_USER:$GALAXY_USER_PASSWD
    sudo -E su $GALAXY_TRAVIS_USER -c "export PATH=$GALAXY_HOME/.local/bin/:$PATH &&
        cd $GALAXY_HOME &&
        bioblend-galaxy-tests -v $GALAXY_HOME/.local/lib/python2.7/site-packages/bioblend/_tests/TestGalaxy*.py"
fi

if [[ $TRAVIS_JOB = "ansible" ]]; then
    echo "Bioblend Testing"
    curl --fail ${BIOBLEND_GALAXY_URL}/api/version
    date > $HOME/date.txt && curl --fail -T $HOME/date.txt ftp://localhost:21 --user $GALAXY_USER:$GALAXY_USER_PASSWD
    sudo -E su $GALAXY_TRAVIS_USER -c "export PATH=$GALAXY_HOME/.local/bin/:$PATH &&
        cd $GALAXY_HOME &&
        bioblend-galaxy-tests -v $GALAXY_HOME/.local/lib/python2.7/site-packages/bioblend/_tests/TestGalaxy*.py"
fi
