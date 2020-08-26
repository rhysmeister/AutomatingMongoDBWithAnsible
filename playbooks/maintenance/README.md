
# Run playbook against Vagrant create replicaset

```bash
ansible-playbook all -i ../replicaset/.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory --ask-vault-pass --become rolling_os_update.yml
```
