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


def test_monbgodb_service(host):
    service = host.service("mongod")
    assert service.is_running
    assert service.is_enabled


def test_mongodb_port(host):
    socket = host.socket("tcp://0.0.0.0:27017")
    assert socket.is_listening

def test_debug(host):
    with host.sudo():
        host.check_output("netstat -tulpen")


@pytest.mark.skipif(os.environ.get('MONGO_REBOOT_TEST', '') != 'TRUE', reason="MONGO_VERSION environment variable is not set")
def test_mongodb_reboot(host):
    '''
    Reboot the host and check the mongod service comes back up
    '''
    #rebooted = host.ansible("reboot", "msg='Reboot initiated from Testinfra.'", become=True, become_user="root")
    #assert rebooted["rebooted"]
    # This version works
    #host.ansible("command", "reboot", check=False, become=True)
    host.run("sudo reboot")
    time.sleep(60)

    service = host.service("mongod")
    assert service.is_running
    assert service.is_enabled

    socket = host.socket("tcp://0.0.0.0:27017")
    assert socket.is_listening
