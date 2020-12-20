
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

# Create a tar backup from a Vagrant host

```bash
vagrant ssh mongodb2
sudo su -
systemctl stop mongod
tar czf mongo.tar.gz /var/lib/mongo
systemctl start mongod
mv mongo.tar.gz /home/vagrant/
chown vagrant:vagrant /home/vagrant/mongo.tar.gz
exit
exit
vagrant plugin install vagrant-scp
vagrant scp mongodb2:/home/vagrant/mongo.tar.gz .
```

# Notes

```bash
tar xvf /var/lib/mongod_backup.tar.gz -C /var/lib/ && chown mongod:mongod /var/lib/mongo && restorecon -R -v /var/lib/mongo && systemctl start mongod
```
