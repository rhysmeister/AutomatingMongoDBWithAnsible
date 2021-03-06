import os
import time
import pytest

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['ANSIBLE_INVENTORY']
).get_hosts('all')

def test_mongodb_config(host):
    file = host.file("/etc/mongod.conf")
    assert file.exists


def test_mongodb_service(host):
    service = host.service("mongod")
    assert service.is_running
    assert service.is_enabled


def test_mongodb_port(host):
    socket = host.socket("tcp://0.0.0.0:27017")
    assert socket.is_listening


@pytest.mark.skipif(os.environ.get('MONGO_REBOOT_TEST', '') != 'TRUE', reason="MONGO_VERSION environment variable is not set")
def test_mongodb_reboot(host):
    '''
    Reboot the host and check the mongod service comes back up
    '''
    host.run("sudo reboot")
    time.sleep(60)

    service = host.service("mongod")
    assert service.is_running
    assert service.is_enabled

    socket = host.socket("tcp://0.0.0.0:27017")
    assert socket.is_listening
