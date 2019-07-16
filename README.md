![metavisitor_logo](extra-files/metavisitor/logo.png)

This is the repository for the automated deployment of a [Metavisitor](https://doi.org/10.1371/journal.pone.0168397) Galaxy server

**Vir2** the viral database used in Metavisitor is available for [download in figshare](https://figshare.com/articles/vir2_NCBI_21-03-2018/6106892).

## Quick Start

Tested on Ubuntu 14.04 & 16.04 - You must have root access (be sudoer)

- Install git
```
apt-get -y update && apt-get -y install git
```
- Clone locally this repository
```
git clone https://github.com/ARTbio/metavisitor.git
```
- Navigate to metavisitor directory
```
cd metavisitor
```

### For a ansible deployment of metavisitor
- run the `install.sh` script
```
sh install.sh
```
### For a Docker image built
- run the `build_docker_image.sh` script
```
sh build_docker_image.sh
```

