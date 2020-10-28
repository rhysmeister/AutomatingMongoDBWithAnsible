############################################################
# Author: Rhys Campbell                                    #
# Created: 2020.10.28                                      #
# Description: Run either via molecule or run the playbook #
# against the localhost.                                   #
############################################################

#!/bin/bash

set -u;
set -e;

case "$CD" in
  "playbooks/standalone")
      ansible-playbook \
        --become \
        --connection=local \
        --inventory 127.0.0.1, \
        --limit 127.0.0.1 mongodb.yml -i ansible_hosts ;;
  "playbooks/replicaset" | "playbooks/sharded_cluster")
      travis-wait-improved --timeout 50m molecule test --scenario-name "$SCENARIO" ;;
esac
