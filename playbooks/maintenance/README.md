
# Run playbook against Vagrant create replicaset

```bash
ansible-playbook -i ../replicaset/.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory --ask-vault-pass --become rolling_os_update.yml
```

# Run the mongodb replicaset upgrade playbook

```bash
ansible-playbook -i ../replicaset/.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory --ask-vault-pass --become mongodb_replicaset_upgrade.yml
```
