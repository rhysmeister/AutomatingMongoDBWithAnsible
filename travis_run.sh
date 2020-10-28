############################################################
# Author: Rhys Campbell                                    #
# Created: 2020.10.28                                      #
# Description: Run either via molecule or run the playbook #
# aginst the localhost.                                    #
############################################################

#!/bin/bash

set -u;
set -e;

case "$CD" in
  "playbooks/standlone" )
      ansible-playbook \
        --connection=local \
        --inventory 127.0.0.1, \
        --limit 127.0.0.1 mongodb.yml -i ansible_hosts
  "plabooks/replicaset" )
      travis_wait 50 molecule test --scenario-name "$SCENARIO" ;;
  "playooks/sharded_cluster" )
      travis_wait 50 molecule test --scenario-name "$SCENARIO" ;;
esac
