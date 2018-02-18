# Next we upload to docker
docker tag metavisitor artbio/metavisitor-2.0:$TRAVIS_COMMIT
docker tag metavisitor artbio/metavisitor-2.0:latest
LOGIN="docker login -e=$DOCKER_EMAIL -u=$DOCKER_USERNAME -p=$DOCKER_PASSWORD"
$LOGIN || (sleep 5s && $LOGIN || echo "login failed twice, quitting" && exit 1)
docker push artbio/metavisitor-2.0:$TRAVIS_COMMIT || (sleep 5s && docker push artbio/galaxy-kickstart-base:$TRAVIS_COMMIT || echo "push failed twice, quitting" && exit 1)
docker push artbio/metavisitor-2.0:latest || (sleep 5s && docker push artbio/galaxy-kickstart-base:latest || echo "push failed twice, quitting" && exit 1)
