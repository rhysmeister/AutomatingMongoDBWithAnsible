import os
import pytest


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
    hostname = host.check_output('hostname -s')
    if hostname in ['mongodb1', 'mongodb2', 'mongodb3']:
        cmd = host.run("mongo --port 27018 --eval 'db.runCommand({ isMaster: 1 })'")
        assert "mongodb1.local:27018" in cmd.stdout
        assert "mongodb2.local:27018" in cmd.stdout
        assert "mongodb3.local:27018" in cmd.stdout
        print("Tests passed for {0}".format(hostname))
    elif hostname in ['mongodb4', 'mongodb5', 'mongodb6']:
        cmd = host.run("mongo --port 27018 --eval 'db.runCommand({ isMaster: 1 })'")
        assert "mongodb4.local:27018" in cmd.stdout
        assert "mongodb5.local:27018" in cmd.stdout
        assert "mongodb6.local:27018" in cmd.stdout
        print("Tests passed for {0}".format(hostname))


def test_mongodb_cfg_replicaset(host):
    hostname = host.check_output('hostname -s')
    if hostname in ['mongos1', 'mongos2', 'mongos3']:  # confgi servers test
        cmd = host.run("mongo --port 27019 --eval 'db.runCommand({ isMaster: 1 })'")
        assert "mongos1.local:27019" in cmd.stdout
        assert "mongos2.local:27019" in cmd.stdout
        assert "mongos3.local:27019" in cmd.stdout


def test_mongodb_mongos(host):
    hostname = host.check_output('hostname -s')
    if hostname in ['mongos1', 'mongos2', 'mongos3']:
        cmd = host.run("mongo --port 27017 --eval 'db.runCommand({ isMaster: 1 })'")
        assert "ismaster" in cmd.stdout
        assert "clusterTime" in cmd.stdout
        print("Tests passed for {0}".format(hostname))


@pytest.mark.skipif(os.environ.get( 'PYTESTSKIP', '' ) == 'TRUE', reason="PYTESTSKIP environment variable is TRUE")
def test_mongodb_mongos_auth(host):
        hostname = host.check_output('hostname -s')
        if hostname in ['mongos1', 'mongos2', 'mongos3']:
            cmd = host.run("mongo admin -u admin -p secret --port 27017 --eval 'db.runCommand({ listShards: 1 })'")
            assert "rs0/mongodb1.local:27018,mongodb2.local:27018,mongodb3.local:27018" in cmd.stdout
            assert "rs1/mongodb4.local:27018,mongodb5.local:27018,mongodb6.local:27018" in cmd.stdout
