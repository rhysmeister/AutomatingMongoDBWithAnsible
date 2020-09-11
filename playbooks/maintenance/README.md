
# Run playbook against Vagrant create replicaset

```bash
ansible-playbook -i ../replicaset/.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory --ask-vault-pass --become rolling_os_update.yml
```

# Run the mongodb replicaset upgrade playbook

```bash
ansible-playbook -i ../replicaset/.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory --ask-vault-pass --become mongodb_replicaset_upgrade.yml
```

# Run the oplog resize playbook

```bash
ansible-playbook -i ../replicaset/.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory --ask-vault-pass --become resize_oplog.yml
```

# Run the resync playbook against a single replicaset member

```bash
ansible-playbook -l mongodb2 -i ../replicaset/.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory --ask-vault-pass --become resync_member.yml
```

# Run the resync from tar playbook against a single replicaset member

```bash
ansible-playbook -l mongodb2 -i ../replicaset/.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory --ask-vault-pass --become resync_member_from_tar.yml
```
