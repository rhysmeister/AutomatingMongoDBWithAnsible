#!/bin/bash

python --version;
pip freeze;
echo "vagrant: " && vagrant version;
echo "virtualbox: " && vboxmanage --version;
docker --version;
echo "uname: " && uname -a;
echo "free: " && free -m;
