#!/bin/bash
set -e;
set -u;
set -x;

sudo apt-get update;
python --version;
pip install --upgrade pip;
pip install --requirement requirements.txt;
if [ "$COLLECTION" == "latest" ]; then
  wget https://github.com/ansible-collections/community.mongodb/releases/download/latest/community-mongodb-latest.tar.gz;
  ansible-galaxy collection install community-mongodb-latest.tar.gz;
elif [ "$COLLECTION" == "requirements.yml" ]; then
  ansible-galaxy collection install -r requirements.yml;
else
  echo "Invalid value for COLLECTION given";
  exit 1;
fi;
pip --version;
ansible --version;
molecule --version;
pytest --version;
