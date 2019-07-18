# metavisitor-2

This is the repository for the automated deployment of a [Metavisitor](https://doi.org/10.1371/journal.pone.0168397) Galaxy server

## Quick Start

Tested on Ubuntu 16.04
  - You must have root access (be sudoer)
  - You need git install (`sudo apt install git -y`)


- Clone locally this repository
```
git clone https://github.com/ARTbio/metavisitor.git
```
- Navigate to metavisitor directory
```
cd metavisitor
```

#### Deploy Metavisitor with ansible:
```
sh local_metavisitor_ansible_build.sh
```

### Deploy Metavisitor with docker
```
sh local_metavisitor_docker_build.sh
```

### Docker image available at https://cloud.docker.com
Run example:
```
docker run -d -p 80:80 -p 21:21 -p 8800:8800 \
             --privileged=true \
             -e GALAXY_CONFIG_ALLOW_USER_DATASET_PURGE=True \
             -e GALAXY_CONFIG_ALLOW_LIBRARY_PATH_PASTE=True \
             -e GALAXY_CONFIG_ENABLE_USER_DELETION=True \
             -e GALAXY_CONFIG_ENABLE_BETA_WORKFLOW_MODULES=True \
             -e NGINX_GALAXY_LOCATION=/subdir \
             -v /tmp/:/tmp/ \
             -v /export:/export \
             artbio/metavisitor-2
```

