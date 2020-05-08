import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['ANSIBLE_INVENTORY']
).get_hosts('all')

def test_mongodb_config(host):
    file = host.file("/etc/mongod.conf")
    assert file.exists


def test_monbgodb_service(host):
    service = host.service("mongod")
    assert service.is_running
    assert service.is_enabled


def test_mongodb_replicaset(host):
    cmd = host.run("mongo --eval 'db.runCommand({ isMaster: 1 })'")
    assert "mongodb1.local:27017" in cmd.stdout
    assert "mongodb2.local:27017" in cmd.stdout
    assert "mongodb3.local:27017" in cmd.stdout
