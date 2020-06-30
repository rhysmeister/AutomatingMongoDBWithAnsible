import testinfra.utils.ansible_runner
import os

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']
).get_hosts('all')


def test_mongod_port(host):
    if host.ansible.get_variables()['inventory_hostname'].startswith("mongodb"):
        s = host.socket("tcp://0.0.0.0:{0}".format(27018))
        assert s.is_listening


def test_mongod_replicaset(host):
    '''
    Ensure that the MongoDB replicaset has been created successfully
    '''
    cmd = "mongo --port 27018 --username admin --password secret --eval 'rs.status()'"
    # We only want to run this once
    if host.ansible.get_variables()['inventory_hostname'] == "mongodb1":
        r = host.run(cmd)
        assert "rs0" in r.stdout
        assert "mongodb1.local:{0}".format(port) in r.stdout
        assert "mongodb2.local:{0}".format(port) in r.stdout
        assert "mongodb3.local:{0}".format(port) in r.stdout
    if host.ansible.get_variables()['inventory_hostname'] == "mongodb4":
        r = host.run(cmd)
        assert "rs1" in r.stdout
        assert "mongodb4.local:{0}".format(port) in r.stdout
        assert "mongodb5.local:{0}".format(port) in r.stdout
        assert "mongodb6.local:{0}".format(port) in r.stdout

# TODO Verification for mongos
