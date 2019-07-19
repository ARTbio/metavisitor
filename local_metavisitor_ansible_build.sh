#!/usr/bin/env bash
set -e
apt-get update -y
apt-get install -y python-pip python-dev htop
echo "Upgrading pip"
python -m pip install -U pip
pip --version
/usr/local/bin/pip install ansible==2.7.4
ansible --version

git clone https://github.com/ARTbio/galaxykickstart.git
cp Dockerfile galaxykickstart/
cp group_vars/metavisitor galaxykickstart/group_vars/
cp -a extra-files/metavisitor galaxykickstart/extra-files/
cp inventory_files/metavisitor galaxykickstart/inventory_files/
cd galaxykickstart/

ansible-galaxy install -r requirements_roles.yml -p roles
ansible-playbook -i inventory_files/metavisitor galaxy.yml
echo "Sleeping 15 sec before restarting Metavisitor Test Galaxy server"
echo "zzzz zzzz..."
sleep 15
supervisorctl restart galaxy:
sleep 15
supervisorctl status
