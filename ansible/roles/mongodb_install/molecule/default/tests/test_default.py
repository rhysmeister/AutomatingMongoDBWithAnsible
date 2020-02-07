import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']
).get_hosts('all')


def test_mongod_available(host):
    cmd = host.run("mongod --version")
    assert cmd.rc == 0


def test_mongos_available(host):
    cmd = host.run("mongos --version")
    assert cmd.rc == 0


def test_mongo_available(host):
    cmd = host.run("mongo --version")
    assert cmd.rc == 0


def test_mongodump_available(host):
    cmd = host.run("mongodump --version")
    assert cmd.rc == 0


def test_mongostat_available(host):
    cmd = host.run("mongostat --version")
    assert cmd.rc == 0


def test_mongoexport_available(host):
    cmd = host.run("mongoexport --version")
    assert cmd.rc == 0


def test_mongoimport_available(host):
    cmd = host.run("mongoimport --version")
    assert cmd.rc == 0


def test_mongorestore_available(host):
    cmd = host.run("mongorestore --version")
    assert cmd.rc == 0


def test_mongotop_available(host):
    cmd = host.run("mongotop --version")
    assert cmd.rc == 0
