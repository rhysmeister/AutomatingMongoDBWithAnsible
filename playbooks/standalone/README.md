

# Run TestInfra tests

```
vagrant ssh-config > .vagrant/ssh-config
export ANSIBLE_INVENTORY=.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory;
export MONGO_REBOOT_TEST='TRUE'; # If so desired
py.test --ssh-config=.vagrant/ssh-config tests_mongodbstandalone.py
```
