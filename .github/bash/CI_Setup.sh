#!/bin/bash
set -e;
set -u;
sudo apt-get update;
python --version;
pip install --upgrade pip;
export pyv=$(python -c 'from platform import python_version; print(python_version()[:3])');
pip install --requirement requirements-${pyv}.txt;
ansible-galaxy collection install community.general;
wget https://github.com/ansible-collections/community.mongodb/releases/download/latest/community-mongodb-latest.tar.gz;
ansible-galaxy collection install community-mongodb-latest.tar.gz;
pip --version;
ansible --version;
molecule --version;
pytest --version;
