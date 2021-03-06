![metavisitor_logo](extra-files/metavisitor/logo.png)

This is the repository for the automated deployment of a [Metavisitor](https://doi.org/10.1371/journal.pone.0168397) Galaxy server.

The Metavisitor [Documentation](https://artbio.github.io/metavisitor/) is available on https://artbio.github.io/metavisitor/

The viral **Vir2** database used in Metavisitor is available for [download in figshare](https://figshare.com/articles/vir2_NCBI_21-03-2018/6106892).

## Quick Start - Deploy Galaxy Metavisitor instance on a target Ubuntu machine

Tested on Ubuntu 16.04
  - You need root access (be sudoer)
  - You need git install (`sudo apt install git -y`)

- Clone locally this repository
```
git clone https://github.com/ARTbio/metavisitor.git
```
- Navigate to metavisitor directory
```
cd metavisitor
```

### Deploy Metavisitor with ansible:
```
sh local_metavisitor_ansible_build.sh
```

### Deploy Metavisitor with docker
```
sh local_metavisitor_docker_build.sh
```

### Docker image `artbio/metavisitor-2` available at https://cloud.docker.com
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

