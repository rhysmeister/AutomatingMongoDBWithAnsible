#!/bin/bash
set -e;
set -u;

sudo apt-get update;
python --version;
pip install --upgrade pip;
export pyv=$(python -c 'from platform import python_version; print(python_version()[:3])');
if [ "$pyv" == "2.7" ]; then
  pip install --requirement requirements-2.7.txt;
else
  pip install --requirement requirements.txt;
fi;

export ANSIBLE_VERSION=$(ansible --version | head -n 1);

if [ "$ANSIBLE_VERSION" =~ '^ansible 2.*' ]; then
  if [ "$COLLECTION" == "dev" ]; then
    wget https://github.com/ansible-collections/community.mongodb/releases/download/latest/community-mongodb-latest.tar.gz;
    ansible-galaxy collection install community-mongodb-latest.tar.gz;
  elif [ "$COLLECTION" == "stable" ]; then
    ansible-galaxy collection install -r requirements.yml;
  else
    echo "Invalid value for COLLECTION given";
    exit 1;
  fi;
elif [ "$ANSIBLE_VERSION" == '^ansible 4.*' ]; then
  if [ "$COLLECTION" == "dev" ]; then
    wget https://github.com/ansible-collections/community.mongodb/releases/download/latest/community-mongodb-latest.tar.gz;
    ansible-galaxy collection install community-mongodb-latest.tar.gz;
    ansible-galaxy collection install community.docker;
  elif [ "$COLLECTION" == "stable" ]; then
    ansible-galaxy collection install -r requirements-4.2+.yml;
  else
    echo "Invalid value for COLLECTION given";
    exit 1;
  fi;
else
  echo "Unepxected ansible version!";
  exit 1;
fi;
pip --version
ansible --version;
molecule --version;
pytest --version;
