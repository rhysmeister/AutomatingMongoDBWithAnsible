



* Do this first!

Edit the variables and set your own usernames and password as appropriate.

It's also a good idea to replace

```
ansible-vault edit vault.yml
```

Default password for the vault.yml file is 'secret'. It's also a good idea to replace the value of openssl_keyfile_content with something else. You can use the following command to generate something suitable

```
openssl rand -base64 756
```

Then set your own password for the vault.yml file.

```
ansible-vault rekey vault.yml
```

* Example vault.yml file

```
---
admin_user: "admin"
admin_user_password: "XXXXXXXXXX"

app_users:
  - username: myapp_ro
    password: XXXXXXXXXX
    database: myapp
    roles:
      - read
  - username: myapp_rw
    password: XXXXXXXXXX
    database: myapp
    roles:
      - readWrite
  - username: myapp_admin
    password: XXXXXXXXXX
    database: myapp
    roles:
      - dbadmin
      - readWrite

openssl_keyfile_content: |
  Z2CeA9BMcoY5AUWoegjv/XWL2MA1SQcL4HvmRjYaTjSp/xosJy+LL2X3OQb1xVWC
  rO2e6Tu6A3R4muunitI6Vr0IKeU5UbTpR0N4hSU6HDrV9z2PIEWlkQqKh01ZRLEY
  V3hR73acj0jA8eWIWeiV039d18jvMb8X2h8409lfcD6PPJJGjyaC8S4LY/TrsK2z
  tx+l/vqOOAMhGB5mEMjx1LXUMsRG9ot6vFu9I5LPd1A4q9xw9jddYK5C6YTLccun
  ZyCDsv7ImkCprV0+0vhTyxIEnfaNtvOlWypuvmRr/DEyd2NPowd1n6C+rgk8gs1t
  SGLCZP93gXza0rIoQzHtuf5pOJK9qyKjuNtuuLa/KFsida8a69JXn7fmS0IIja0m
  Ir0OrQ2Ta3n4VbQwQo97BWODWmkgzz0mUd6VmMps5zLsCW1vVqYFQHuAAbLekW0q
  8JRm8OQ6n2hp8j4zYd3/Qw7vqsVj8sHicNB0bCW29b64H4f2J/AcUA/cm0xSUQyb
  +myeCB4vWvydh5AfFVnw7sXvzU6egaYRomdmrl59QrTDneJu13hwzIchsFparoWJ
  XjpldopGeDaJLU18ga7MSL02ozB+EoJ14DJxQU7E5MQk7fDMPeitXKZ8ymxb7LeA
  k0Rtc/JQM8aDLoRklhLZRRARBrv1RLo8DM8CB2q4s+FwVU4QJl7mFyiwk3eTN6sN
  PTgFRo3/dHsEA2OwGG+hnGFGnoYf2mkECR5jqai83CXgva9v2rPNjDTJYHpmd3I0
  fNijueXZZdzUA58y8mcoSGVYdRhr0g8jaWQ12PZEgX5Nnlekh5GHG0j8HT4qj/0Y
  D3xVuE3WvrhldY5EOsaTt2ZXZx5REmJDIW1KcnvQKiVDJ2QzP5xdXYA0hh3TdTVE
  sb4UreMw/WyBpANiICMlJRBgSd0f0VGMlYzLX2BL14YpNnLhmoQqKzfBN6v2XAEG
  mJfrCUVuP1nBEklk23lYkNi/ohe+aodNjdN+2DHp42sGZHYP
```

# Run TestInfra tests

```
vagrant ssh-config > .vagrant/ssh-config
export ANSIBLE_INVENTORY=.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory;
py.test --ssh-config=.vagrant/ssh-config tests_mongodb_sharded_cluster.py
```

# Run TestInfra tests requiring auth

Some tests require the password for the root MongoDB user these can be set as follows. If the MONGO_USER variable is unset, or an empty string, the relevant tests will be skipped.


```
export MONGO_USER=XXXXXXX;
export MONGO_PWD=XXXXXXX;
py.test --ssh-config=.vagrant/ssh-config tests_mongodb_sharded_cluster.py;
```
