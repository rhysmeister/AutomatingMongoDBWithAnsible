import os, time
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
    elif hostname in ['mongodb7', 'mongodb8', 'mongodb9']:
        cmd = host.run("mongo --port 27018 --eval 'db.runCommand({ isMaster: 1 })'")
        assert "mongodb7.local:27018" in cmd.stdout
        assert "mongodb8.local:27018" in cmd.stdout
        assert "mongodb9.local:27018" in cmd.stdout
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


@pytest.mark.skipif(os.environ.get('MONGO_USER', '') == '', reason="MONGO_USER environment variable is not set")
def test_mongodb_mongos_auth(host):
    MONGO_USER = os.environ.get('MONGO_USER')
    MONGO_PWD = os.environ.get('MONGO_PWD')
    hostname = host.check_output('hostname -s')
    if hostname in ['mongos1', 'mongos2', 'mongos3']:
        cmd = host.run("mongo admin -u {0} -p '{1}' --port 27017 --eval 'db.runCommand({{ listShards: 1 }})'".format(MONGO_USER, MONGO_PWD))
        assert 'rs0/mongodb1.local:27018,mongodb2.local:27018,mongodb3.local:27018' in cmd.stdout
        assert 'rs1/mongodb4.local:27018,mongodb5.local:27018,mongodb6.local:27018' in cmd.stdout


@pytest.mark.skipif(os.environ.get('MONGO_VERSION', '') == '', reason="MONGO_VERSION environment variable is not set")
def test_mongodb_version(host):
    MONGO_VERSION = os.environ.get('MONGO_VERSION')
    hostname = host.check_output('hostname -s')
    if hostname.startswith("mongodb"):
        cmd = host.run("mongod --version")
        assert MONGO_VERSION in cmd.stdout
    elif hostname.startswith("mongos"):
        cmd = host.run("mongod --version")
        assert MONGO_VERSION in cmd.stdout
        cmd = host.run("mongos --version")
        assert MONGO_VERSION in cmd.stdout


@pytest.mark.skipif(os.environ.get('MONGO_REBOOT_TEST', '') != 'TRUE', reason="MONGO_VERSION environment variable is not set")
def test_mongodb_reboot(host):
    '''
    Reboot the host and check the mongod service comes back up
    '''
    hostname = host.check_output('hostname -s')
    host.run("sudo reboot")
    time.sleep(60)

    if hostname.startswith("mongodb"):
        service = host.service("mongod")
        assert service.is_running
        assert service.is_enabled
        socket = host.socket("tcp://0.0.0.0:27018")
        assert socket.is_listening
    elif hostname.startswith("mongos"):
        service = host.service("mongod") # config server
        assert service.is_running
        assert service.is_enabled
        socket = host.socket("tcp://0.0.0.0:27019")
        assert socket.is_listening
        service = host.service("mongos") # mongos server
        assert service.is_running
        assert service.is_enabled
        socket = host.socket("tcp://0.0.0.0:27017")
        assert socket.is_listening
