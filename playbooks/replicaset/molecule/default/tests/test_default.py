import testinfra.utils.ansible_runner
import os

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']
).get_hosts('all')


def include_vars(host):
    if host.system_info.distribution == "redhat" \
            or host.system_info.distribution == "centos":
        ansible = host.ansible('include_vars',
                               'file="../../vars/RedHat.yml"',
                               False,
                               False)
    if host.system_info.distribution == "debian" \
            or host.system_info.distribution == "ubuntu":
        ansible = host.ansible('include_vars',
                               'file="../../vars/Debian.yml"',
                               False,
                               False)
    return ansible


def test_mongod_port(host):
    try:
        port = include_vars(host)['ansible_facts']['mongod_port']
    except KeyError:
        port = 27017
    s = host.socket("tcp://0.0.0.0:{0}".format(port))
    assert s.is_listening


def test_mongod_replicaset(host):
    '''
    Ensure that the MongoDB replicaset has been created successfully
    '''
    try:
        port = include_vars(host)['ansible_facts']['mongod_port']
    except KeyError:
        port = 27017
    cmd = "mongo --port {0} --username admin --password secret --eval 'rs.status()'".format(port)
    # We only want to run this once
    if host.ansible.get_variables()['inventory_hostname'] == "mongodb1":
        r = host.run(cmd)
        assert "rs0" in r.stdout
        assert "mongodb1.local:{0}".format(port) in r.stdout
        assert "mongodb2.local:{0}".format(port) in r.stdout
        assert "mongodb3.local:{0}".format(port) in r.stdout
