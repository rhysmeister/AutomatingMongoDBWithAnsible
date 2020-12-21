#!/bin/bash
set -e;
set -u;
sudo apt-get update;
python --version;
pip install --upgrade pip;
pip install --requirement requirements.txt;
ansible-galaxy collection install community.general;
wget https://github.com/ansible-collections/community.mongodb/releases/download/latest/community-mongodb-latest.tar.gz;
ansible-galaxy collection install community-mongodb-latest.tar.gz;
pip --version;
ansible --version;
molecule --version;
pytest --version;
