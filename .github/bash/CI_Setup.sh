#!/bin/bash
set -e;

sudo apt-get update;
python --version;
pip install --upgrade pip;
pip install --requirement requirements.txt;
if [ -n "$LATEST" ]; then
  ansible-galaxy collection install community.general;
  wget https://github.com/ansible-collections/community.mongodb/releases/download/latest/community-mongodb-latest.tar.gz;
  ansible-galaxy collection install community-mongodb-latest.tar.gz;
else
  ansible-galaxy collection install -r requirements.yml
fi;
pip --version;
ansible --version;
molecule --version;
pytest --version;
